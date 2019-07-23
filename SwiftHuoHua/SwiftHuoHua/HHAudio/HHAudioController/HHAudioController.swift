//
//  HHAudioController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/22.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHAudioController: HHBaseViewController {

    private lazy var scrollview: UIScrollView = {
       let scro = UIScrollView()
        
        return scro
    }()
    //音频节目列表
    fileprivate lazy var audioListvc: HHAudioListViewController = {
       let vc = HHAudioListViewController()
        return vc
    }()
    //音频介绍
    fileprivate lazy var audiointroducevc: HHAudioIntroduceViewController = {
        let vc = HHAudioIntroduceViewController()
        return vc
    }()
    
    fileprivate lazy var hhpageController: HHPageViewController = {
        let page = HHPageViewController(titles: ["节目","简介"], vcs: [audioListvc,audiointroducevc], pageStyle: .topTabBar)
        return page
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="音频详情"
        
    }
    override func configUI() {
        super.configUI()
        self.addChild(hhpageController)
        self.view.addSubview(hhpageController.view)
        hhpageController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
