//
//  HHAudioAlbumViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/27.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHAudioAlbumViewController: HHBaseViewController {
    private let cellid = "cellid"
    fileprivate var pageNum: Int = 0
    fileprivate var pageSize: Int?
    fileprivate var selectrow: Int?
    fileprivate var audiolistModelArray = [homeAudioModel]()
    fileprivate lazy var tableview: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource=self
        table.delegate=self
        table.rowHeight=UITableView.automaticDimension
        table.estimatedRowHeight=0
        table.separatorStyle=UITableViewCell.SeparatorStyle.none
        table.register(UINib(nibName: "HomeAudioListCell", bundle: nil), forCellReuseIdentifier: cellid)
        table.HHHead=HHRefreshHeader(refreshingBlock: {[weak self] in
            self?.pageNum = 0
            self?.requestData()
        })
        table.HHFoot=HHRefreshFooter(refreshingBlock: {
            self.pageNum += 1
            self.requestData()
        })
        table.separatorStyle=UITableViewCell.SeparatorStyle.none
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func configUI() {
        super.configUI()
        self.pageNum = 0
        self.pageSize = 10
        self.title = "音频列表"
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview()
        }
        
        requestData()
    }
}

extension HHAudioAlbumViewController
{
    func requestData() {
        ApiLoadingProvider.request(.loadHomeAudioList(pageNum: self.pageNum ?? 0, pageSize: self.pageSize ?? 0), model: homeAudioListModel.self) { (returndata, errcode) in
            self.tableview.HHHead.endRefreshing()
            self.tableview.HHFoot.endRefreshing()
            if errcode == 0
            {
                //成功
                if self.pageNum == 0
                {
                    self.audiolistModelArray.removeAll()
                }
                self.audiolistModelArray.append(contentsOf: returndata?.list ?? [])
            }
            else {
                
            }
            self.tableview.reloadData()
            
        }
    }
}

extension HHAudioAlbumViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.audiolistModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! HomeAudioListCell
        cell.setDataModel(model: self.audiolistModelArray[indexPath.row])
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectrow = indexPath.row
        var model = self.audiolistModelArray[indexPath.row]
        let vc = HHAudioController()
        vc.backClosure = { (str) in
            print(str)
            model.tipTypeCode=1
            self.audiolistModelArray[self.selectrow ?? 0] = model
            self.tableview.reloadData()
        }
        vc.audioDetailid = model.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KSuitFloat(float: 165)
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


