//
//  HomeRecommendVC.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/24.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
import MBProgressHUD
class HomeRecommendVC: HHBaseViewController {
    let cellid = "cellid"
    let bannerCellid = "bannerCellid"
    let audioid = "audiocellid"
    //推荐帖子列表model数组
    private var homecircleModel = [homeCircleModel]()
    //推荐音频列表model数组
    private var homeaudioModel = [homeAudioModel]()
    //首页banner 数组
    private var homebannerModel = [HomeBannerModel]()
    //所有请求数组集合
    private var sumModelArray = [Any]()
    //懒加载tableview
    fileprivate lazy var tableview : UITableView = { [unowned self] in
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource=self
        table.delegate=self
        table.estimatedRowHeight=44
        table.rowHeight=UITableView.automaticDimension
        table.register(UINib(nibName: "HHHomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellid)
        table.register(UINib(nibName: "HomeBannerCell", bundle: nil), forCellReuseIdentifier: bannerCellid)
        table.register(UINib(nibName: "HomeAudioCell", bundle: nil), forCellReuseIdentifier: audioid)
        table.separatorStyle = .none
        //刷新加载数据
        table.HHHead = HHRefreshHeader(refreshingBlock: {[weak self] in
            self?.sumModelArray.removeAll()
            self?.requestData()
        })
        table.HHFoot = HHRefreshFooter(refreshingBlock: {
            table.HHFoot.endRefreshing()
        })
        return table
        }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configUI() {
        super.configUI()
        // 添加列表
        self.view.addSubview(self.tableview)
        tableview.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.bottom.equalTo(-TAB_BAR_HEIGHT)
        }
        requestData()
    }
    override func configNavigationBar() {
        super.configNavigationBar()
        

    }
}

extension HomeRecommendVC{
    //请求网络数据
    func requestData() {
        //线程组
        let group = DispatchGroup()
        //线程队列，全局的
        MBProgressHUD.showAdded(to: self.view, animated: true)
        group.enter()
        //加载轮播图数据
        ApiProvider.request(.loadHomeBanner, model: HomeBannerModel.self) {[weak self] (returnData,errnocode) in
            if errnocode == 0{
                //服务器返回成功
            }
            else{
                //服务器返回失败
            }
            group.leave()
        }
        //圈子列表
        group.enter()
        ApiProvider.request(.loadHomeCircleList(page: 0), model: homeCircleListModel.self) {[weak self] (returnData, errnocode) in
            if errnocode == 0{
                self?.homecircleModel=returnData?.list ?? []
            }
            else{
                
            }
            group.leave()
        }
        // 推荐音频
        group.enter()
        ApiProvider.request(.loadHomeAudio, model: homeAudioListModel.self) {[weak self] (returnData, errnocode) in
            if errnocode == 0 {
                self?.homeaudioModel=returnData?.list ?? []
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            //统一处理请求数据
            self.tableview.HHHead.endRefreshing()
            self.tableview.HHFoot.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
            self.sumModelArray.append("http://omxx7cyms.bkt.clouddn.com/o_1detrosj41bo2p58jmkb33m707.jpeg")
            if self.homeaudioModel.count>0
            {
                self.sumModelArray.append(self.homeaudioModel)
            }
            if self.homecircleModel.count > 0
            {
                self.sumModelArray.append(contentsOf: self.homecircleModel)
            }
            self.tableview.reloadData()
        }
    }
}

extension HomeRecommendVC : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.sumModelArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let anymodel = self.sumModelArray[indexPath.row]
        //音频
        if (anymodel as? [homeAudioModel]) != nil
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: audioid, for: indexPath) as! HomeAudioCell
            cell.setModel(modelArray: anymodel as! [homeAudioModel])
            cell.selectionStyle = .none
            return cell
        }
            //banner
        else if (anymodel as? String) != nil
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: bannerCellid, for: indexPath) as! HomeBannerCell
            cell.setDataClick(urlstr: anymodel as! String)
            return cell
        }
        else{
            let model = anymodel as? homeCircleModel
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! HHHomeTableViewCell
            cell.titlelabel.text=model?.title ?? ""
            cell.corverImage.kf.setImage(urlString: model?.avatar ?? "")
            cell.dsclabel.text=model?.nickname ?? ""
            cell.selectionStyle = .none
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}



