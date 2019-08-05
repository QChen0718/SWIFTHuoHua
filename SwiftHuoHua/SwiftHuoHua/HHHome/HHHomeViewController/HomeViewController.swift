//
//  HomeViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/16.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HomeViewController: HHBaseViewController {
    //推荐
    lazy var recommendvc: HomeRecommendVC = {
       let vc = HomeRecommendVC()
        return vc
    }()
    //音频
    lazy var audiovc: HomeAudioViewController = {
       let vc = HomeAudioViewController()
        return vc
    }()
    //直播
    lazy var livevc: HomeLiveViewController = {
       let vc = HomeLiveViewController()
        return vc
    }()
    //方案包
    lazy var solutionvc: HomeSolutionListVC = {
        let vc = HomeSolutionListVC()
        return vc
    }()
    //专题
    lazy var projectvc: HomeProjectVC = {
        let vc = HomeProjectVC()
        return vc
    }()
    //问答
    lazy var societyvc: HomeSocietyVC = {
        let vc = HomeSocietyVC()
        return vc
    }()
    //视频
    lazy var videovc: HomeVideoListVC = {
        let vc = HomeVideoListVC()
        return vc
    }()
    fileprivate lazy var homepagevc: HHPageViewController = {
       let pagevc = HHPageViewController(titles: ["推荐","音频课","直播课","方案包","专题","问答","视频"], vcs: [recommendvc,audiovc,livevc,solutionvc,projectvc,societyvc,videovc], pageStyle: .navigationBarSegment)
        return pagevc
    }()
    //搜索按钮
    fileprivate lazy var searchButon:UIButton = {
        let sn = UIButton(type: .custom)
        sn.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 30)
        sn.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        sn.layer.cornerRadius=15
        sn.setTitleColor(.white, for: .normal)
        sn.setImage(UIImage(named: "nav_search")?.withRenderingMode(.alwaysOriginal), for: .normal)
        sn.setTitle("搜索", for: .normal)
        sn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        sn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        sn.addTarget(self, action: #selector(searchClick(btn:)), for: .touchUpInside)
        return sn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.title="首页"
    }
    override func configUI() {
        //重写父类方法
        super.configUI()
        self.addChild(homepagevc)
        self.view.addSubview(homepagevc.view)
        homepagevc.view.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(0)
//            $0.edges.equalToSuperview()
        }
    }
    override func configNavigationBar() {
        //  UIImage渲染模式 withRenderingMode
        //  Automatic 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
        //  AlwaysOriginal 始终绘制图片原始状态，不使用Tint Color
        //  AlwaysTemplate 始终根据Tint Color绘制图片，忽略图片的颜色信息。
        super.configNavigationBar()
        navigationItem.titleView = searchButon
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_nav_signin")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightClick))
    }
    @objc func rightClick(){
        self.navigationController?.pushViewController(HomeDetailViewController(), animated: true)
    }
}

extension HomeViewController{
    
    @objc func searchClick(btn:UIButton) {
        self.navigationController?.pushViewController(HHSearchViewController(), animated: true)
    }
}

