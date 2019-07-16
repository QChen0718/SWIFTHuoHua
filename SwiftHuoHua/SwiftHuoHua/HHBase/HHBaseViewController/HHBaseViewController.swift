//
//  HHBaseViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/16.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        configUI()
    }
    func configUI() {
        configNavigationBar()
    }
    //初始化导航栏
    func configNavigationBar() {
        guard let navi = navigationController else { return }
        if navi.visibleViewController == self {
            navi.disablePopGesture = false
            navi.navigationbarStyle(.white)
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back_white"), style: .plain, target: self, action: #selector(pressBack));
            }
        }
    }
    //返回按钮点击方法
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
}
