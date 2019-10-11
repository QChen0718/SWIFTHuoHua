//
//  MyFLBFlutterVC.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2019/9/19.
//  Copyright © 2019 White-C. All rights reserved.
//

import flutter_boost

class MyFLBFlutterVC: FLBFlutterViewContainer {
        func configNavigationBar() {
            guard let navi = navigationController else { return }
            if navi.visibleViewController == self {
                navi.disablePopGesture = false
                navi.navigationbarStyle(.white)
                navi.setNavigationBarHidden(false, animated: true)
                if navi.viewControllers.count > 1 {
                    //  UIImage渲染模式 withRenderingMode
                    //  Automatic 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
                    //  AlwaysOriginal 始终绘制图片原始状态，不使用Tint Color
                    //  AlwaysTemplate 始终根据Tint Color绘制图片，忽略图片的颜色信息。
                    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(pressBack));
                }
            }
        }
    //返回按钮点击方法
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
}
