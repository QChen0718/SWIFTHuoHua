//
//  HomeAudioViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/24.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
import MBProgressHUD

enum AudioSectionType: Int {
    case AudioListSectionTypeBanner = 101 // 音频 banner
    case AudioListSectionTypeExcerpt // 每日精选
    case AudioListSectionTypeEntrance // 钬花精品课
    case AudioListSectionTypeWWEC // WWEC精选
}

class HomeAudioViewController: HHBaseViewController {
    fileprivate var selectrow: Int = -1
    fileprivate let audiobannerid = "audiobannerid" //banner
    fileprivate let audiojxid = "audiojxid" //每日精选
    fileprivate let audioselectid = "audioselectid" //钬花精品课
    fileprivate let audiowwecid = "audiowwecid" //独家·WWEC大会精选
    fileprivate var audiobannerModelArray = [HomeBannerModel]()
    fileprivate var audioExcerptModelArray = [audiodirectoryModel]()
    fileprivate var audioselectModelArray = [audioSelectModel]()
    fileprivate var audiowwecModelArray = [homeAudioModel]()
    fileprivate var audiosectionTypeArray = [AudioSectionType]()
    fileprivate var audiosectionModelArray = [Any]()
    fileprivate var audioplayManger = HHAudioPlayManger.sharedInstance
    fileprivate lazy var tableview:UITableView = {
       let table=UITableView(frame: CGRect.zero, style: .grouped)
        table.delegate=self
        table.dataSource=self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.separatorStyle=UITableViewCell.SeparatorStyle.none
        table.HHHead=HHRefreshHeader(refreshingBlock: {[weak self] in
            self?.requestData()
        })

        table.register(UINib(nibName: "HomeBannerCell", bundle: nil), forCellReuseIdentifier: audiobannerid)
        table.register(UINib(nibName: "AudiolistCell", bundle: nil), forCellReuseIdentifier: audiojxid)
        table.register(UINib(nibName: "HomeAudioCell", bundle: nil), forCellReuseIdentifier: audioselectid)
        table.register(UINib(nibName: "HomeAudioListCell", bundle: nil), forCellReuseIdentifier: audiowwecid)
        return table
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func configUI() {
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints {
            $0.edges.equalTo(self.view.hhsnp.edges)
        }
        //加载网络数据
        requestData()
    }
}

extension HomeAudioViewController
{
    fileprivate func requestData(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let group = DispatchGroup()
        group.enter()
        //请求banner数据
        ApiProvider.request(.loadAudioBannerList, model: audiobannerListModel.self) {[weak self] (returndata, errnocode) in
            if errnocode == 0
            {
                self?.audiobannerModelArray.append(contentsOf: returndata?.list ?? [])
                
            }
            else
            {
                
            }
            group.leave()
        }
        //请求每日精选
        group.enter()
        ApiProvider.request(.loadAudioExcerptList(id: 67), model: excerptListModel.self) {[weak self] (returndata, errnocode) in
            if errnocode == 0
            {
                self?.audioExcerptModelArray.append(contentsOf: returndata?.list?.items ?? [])
                
            }
            else
            {
                
            }
            group.leave()
        }
        //请求钬花精品课
        group.enter()
        ApiProvider.request(.loadAudioSelectAudioList, model: audioSelectListModel.self) {[weak self] (returndata, errnocode) in
            if errnocode == 0
            {
                self?.audioselectModelArray.append(contentsOf: returndata?.list ?? [])
                
            }
            else
            {
                
            }
            group.leave()
        }
        //请求wwec课程
        group.enter()
        ApiProvider.request(.loadWWECDataList, model: homeAudioListModel.self) {[weak self] (returndata, errnocode) in
            if errnocode == 0
            {
                self?.audiowwecModelArray.append(contentsOf: returndata?.list ?? [])
                
            }
            else
            {
                
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {[weak self] in
            //处理请求后，数据的处理
            MBProgressHUD.hide(for: self!.view, animated: true)
            self?.tableview.HHHead.endRefreshing()
            self?.audiosectionTypeArray.removeAll()
            self?.audiosectionModelArray.removeAll()
            guard let bannercount = self?.audiobannerModelArray.count  else { return }
            guard let excerptcount = self?.audioExcerptModelArray.count else { return }
            guard let entrancecount = self?.audioselectModelArray.count else { return }
            guard let wweccount = self?.audiowwecModelArray.count else { return }
            if bannercount > 0
            {
                self?.audiosectionTypeArray.append(.AudioListSectionTypeBanner)
                self?.audiosectionModelArray.append(self?.audiobannerModelArray ?? [])
            }
            if excerptcount > 0
            {
                self?.audiosectionTypeArray.append(.AudioListSectionTypeExcerpt)
                self?.audiosectionModelArray.append(self?.audioExcerptModelArray ?? [])
            }
            if entrancecount > 0
            {
                self?.audiosectionTypeArray.append(.AudioListSectionTypeEntrance)
                self?.audiosectionModelArray.append(self?.audioselectModelArray ?? [])
            }
            if wweccount > 0
            {
                self?.audiosectionTypeArray.append(.AudioListSectionTypeWWEC)
                self?.audiosectionModelArray.append(self?.audiowwecModelArray ?? [])
            }
            self?.tableview.reloadData()
        }
    }
}



extension HomeAudioViewController : UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.audiosectionTypeArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = self.audiosectionTypeArray[section]
        if type == .AudioListSectionTypeBanner {
            return 1
        }
        else if type == .AudioListSectionTypeExcerpt
        {
            if self.audioExcerptModelArray.count > 3
            {
                return 3
            }
            else
            {
                return self.audioExcerptModelArray.count
            }
        }
        else {
            return (self.audiosectionModelArray[section] as AnyObject).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = self.audiosectionTypeArray[indexPath.section]
        if type == .AudioListSectionTypeBanner
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: audiobannerid, for: indexPath) as! HomeBannerCell
            let model = self.audiobannerModelArray[indexPath.row]
            cell.setDataClick(urlstr: model.poster ?? "")
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            return cell
        }
        else if type == .AudioListSectionTypeExcerpt
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: audiojxid, for: indexPath) as! AudiolistCell
            cell.indexpath=indexPath
            cell.selectrow=self.selectrow
            cell.setdataModel(model: self.audioExcerptModelArray[indexPath.row])
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            return cell
        }
        else if type == .AudioListSectionTypeEntrance
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: audioselectid, for: indexPath) as! HomeAudioCell
            cell.setselectAudioModel(model: self.audioselectModelArray[indexPath.row])
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: audiowwecid, for: indexPath) as! HomeAudioListCell
            cell.setDataModel(model: self.audiowwecModelArray[indexPath.row])
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = self.audiosectionTypeArray[indexPath.section]
        if type == .AudioListSectionTypeExcerpt {
            self.selectrow = indexPath.row
            self.audioplayManger.playWithModel(tracks: self.audioExcerptModelArray[indexPath.row], indexPathRow: indexPath.row)
            self.tableview.reloadData()
        }
        else if type == .AudioListSectionTypeWWEC {
            let model = self.audiowwecModelArray[indexPath.row]
            let vc = HHAudioController()
            vc.audioDetailid = model.id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let type = self.audiosectionTypeArray[section]
        let btn = UIButton(type: .custom)
        btn.backgroundColor=UIColor.white
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        btn.contentHorizontalAlignment=UIControl.ContentHorizontalAlignment.left
        btn.titleEdgeInsets=UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        btn.frame=CGRect(x: 0, y: 0, width: HHScreenWidth, height: 50)
        if type == .AudioListSectionTypeExcerpt {
            btn.setTitle("每日精选", for: .normal)
            return btn
        }
        else if type == .AudioListSectionTypeEntrance {
            btn.setTitle("钬花精品课", for: .normal)
            return btn
        }
        else if type == .AudioListSectionTypeWWEC
        {
            btn.setTitle("WWEC", for: .normal)
            return btn
        }
        else{
            return UIView()
        }
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let type = self.audiosectionTypeArray[section]
        if type == .AudioListSectionTypeBanner {
            return 0.01
        }
        else
        {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
