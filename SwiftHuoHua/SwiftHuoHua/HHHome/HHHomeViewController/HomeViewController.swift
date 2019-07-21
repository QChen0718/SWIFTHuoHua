//
//  HomeViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/16.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit


class HomeViewController: HHBaseViewController {
    let cellid = "cellid"
    let bannerCellid = "bannerCellid"
    
    //推荐帖子列表model数组
    private var homecircleModel: [homeCircleModel]?
    //推荐音频列表model数组
    private var homeaudioModel: [homeAudioModel]?
    //懒加载tableview
    fileprivate lazy var tableview : UITableView = { [unowned self] in
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource=self
        table.delegate=self
        table.estimatedRowHeight=44
        table.rowHeight=UITableView.automaticDimension
        table.register(UINib(nibName: "HHHomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellid)
        table.register(UINib(nibName: "HomeBannerCell", bundle: nil), forCellReuseIdentifier: bannerCellid)
        
        //刷新加载数据
        table.HHHead = HHRefreshHeader(refreshingBlock: {[weak self] in
            self?.requestData()
        })
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="首页"

        
    }
    override func configUI() {
        //重写父类方法
        super.configUI()
        
        // 添加列表
        self.view.addSubview(self.tableview)
        tableview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        requestData()
        
    }
    override func configNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_nav_signin"), style: .plain, target: self, action: #selector(rightClick))
    }
    @objc func rightClick(){
        self.navigationController?.pushViewController(HomeDetailViewController(), animated: true)
    }
}

extension HomeViewController{
    //请求网络数据
    func requestData() {
        //线程组
        let group = DispatchGroup()
        //线程队列，全局的
        group.enter()
        //加载轮播图数据
        ApiLoadingProvider.request(.loadHomeBanner, model: HomeBannerModel.self) {[weak self] (returnData,errnocode) in
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
        ApiLoadingProvider.request(.loadHomeCircleList(page: 0), model: homeCircleListModel.self) { (returnData, errnocode) in
            if errnocode == 0{
                self.homecircleModel=returnData?.list
            }
            else{
                
            }
            group.leave()
        }
        // 推荐音频
        group.enter()
        ApiLoadingProvider.request(.loadHomeAudio, model: homeAudioListModel.self) { (returnData, errnocode) in
            if errnocode == 0 {
                self.homeaudioModel=returnData?.list
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            //统一处理请求数据
            self.tableview.HHHead.endRefreshing()
            self.tableview.reloadData()
        }
    }
}


extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.homecircleModel?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! HHHomeTableViewCell
        let model = self.homecircleModel?[indexPath.row]
        cell.titlelabel.text=model?.title
        cell.corverImage.kf.setImage(urlString: model?.avatar)
        cell.dsclabel.text=model?.nickname
        return cell
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
