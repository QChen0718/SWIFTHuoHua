//
//  FlowerViewController.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2020/8/3.
//  Copyright © 2020 White-C. All rights reserved.
//

import UIKit

class FlowerViewController: HHBaseViewController {
    fileprivate lazy var postvc:PostViewController={
        let vc = PostViewController()
        return vc
    }()
    fileprivate lazy var contributevc:ContributeViewController={
        let vc = ContributeViewController()
        return vc
    }()
    fileprivate lazy var answervc:AnswerViewController={
        let vc = AnswerViewController()
        return vc
    }()
    fileprivate lazy var flowerpagevc: HHPageViewController = {
        let pagevc = HHPageViewController(titles: ["帖子","投稿","问答"], vcs: [postvc,contributevc,answervc], pageStyle: .navigationBarSegment)
        return pagevc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(flowerpagevc)
        view.addSubview(flowerpagevc.view)
        flowerpagevc.view.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }

}
