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
    fileprivate lazy var homepagevc: HHPageViewController = {
        let pagevc = HHPageViewController(titles: ["关注","我的消息"], vcs: [flowervc,mymessagevc], pageStyle: .navigationBarSegment)
        return pagevc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func configUI() {
        super.configUI()
        addChild(homepagevc)
        view.addSubview(homepagevc.view)
        homepagevc.view.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(0)
        }
    }
}
