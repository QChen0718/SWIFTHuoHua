//
//  HHAudioController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/22.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
//定义闭包类型（特定的函数类型函数类型）
typealias InputClosureType = (String) -> Void

class HHAudioController: HHBaseViewController {

    //接收上个页面传过来的闭包块
    var backClosure: InputClosureType?

    var  audioDetailid : Int?
    private lazy var bottomBtn: UIButton = {
       let btn = UIButton(type: .custom)
        btn.setTitle("购买", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.backgroundColor=UIColor.yellow
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    private lazy var scrollview: UIScrollView = {
       let scro = UIScrollView()
        
        return scro
    }()
    //音频节目列表
    fileprivate lazy var audioListvc: HHAudioListViewController = {
       let vc = HHAudioListViewController()
        vc.audiodetailid=self.audioDetailid
        return vc
    }()
    //音频介绍
    fileprivate lazy var audiointroducevc: HHAudioIntroduceViewController = {
        let vc = HHAudioIntroduceViewController()
        vc.audiodetail_id=self.audioDetailid
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
        self.view.addSubview(bottomBtn)
        bottomBtn.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}

extension HHAudioController {
    @objc func btnClick()
    {
        //购买按钮点击事件
        print("按钮被点击")
        if self.backClosure != nil {
            self.backClosure!("购买")
        }
    }
}
