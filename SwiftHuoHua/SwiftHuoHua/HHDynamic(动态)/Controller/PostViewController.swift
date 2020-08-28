//
//  PostViewController.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2020/8/3.
//  Copyright © 2020 White-C. All rights reserved.
//

import UIKit

class PostViewController: HHBaseViewController {
    fileprivate lazy var circlelistview:CircleListView={
        let tableview = CircleListView(frame: .zero, style: .plain)
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        setFrame()
    }
}

extension PostViewController{
    fileprivate func createUI(){
        view.addSubview(circlelistview)
    }
    fileprivate func setFrame(){
        circlelistview.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(HHScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT-40)
        }
    }
}
