//
//  HHCircleVC.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/8/4.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHCircleVC: HHBaseViewController {
    fileprivate lazy var circlelistview:CircleListView={
        let tableview = CircleListView(frame: .zero, style: .plain)
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title="热门帖子"
        createUI()
        setFrame()
    }
}

extension HHCircleVC {
    fileprivate func createUI(){
        view.addSubview(circlelistview)
    }
    fileprivate func setFrame(){
        circlelistview.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(HHScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT)
        }
    }
}
