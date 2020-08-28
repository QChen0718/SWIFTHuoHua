//
//  HHDynamicController.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2020/8/3.
//  Copyright © 2020 White-C. All rights reserved.
//

import UIKit

class HHDynamicController: HHBaseViewController {
    fileprivate lazy var flowervc:FlowerViewController={
       let vc = FlowerViewController()
        return vc
    }()
    fileprivate lazy var mymessagevc:MyMessageViewController={
       let vc = MyMessageViewController()
        return vc
    }()
    fileprivate lazy var dynamicpagevc: HHPageViewController = {
        let pagevc = HHPageViewController(titles: ["关注","我的消息"], vcs: [flowervc,mymessagevc], pageStyle: .topTabBar)
        return pagevc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
    }
    override func configUI() {
        super.configUI()
        self.addChild(dynamicpagevc)
        view.addSubview(dynamicpagevc.view)
        dynamicpagevc.view.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(STATUS_BAR_HEIGHT)
        }
    }
}
