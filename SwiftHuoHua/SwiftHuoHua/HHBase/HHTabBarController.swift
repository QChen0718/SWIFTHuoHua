//
//  HHTabBarController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/16.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let vc1 = HomeViewController();
        let vc2 = UIViewController();
        let vc3 = UIViewController();
        let vc4 = UIViewController();
        self.addChildViewController(vc1, title: "", image: "buttn_shi_normal",selectImage: "buttn_shi_hover")
        self.addChildViewController(vc2, title: "", image: "buttn_she_normal",selectImage: "buttn_she_hover")
        self.addChildViewController(vc3, title: "", image: "tab_dongtai_normal",selectImage: "tab_dongtai_select")
        self.addChildViewController(vc4, title: "", image: "buttn_wu_normal",selectImage: "buttn_wu_hover");
    }

    func addChildViewController(_ childController:UIViewController,title:String?,image:String?,selectImage:String?) {
        //  UIImage渲染模式 withRenderingMode
        //  Automatic 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
        //  AlwaysOriginal 始终绘制图片原始状态，不使用Tint Color
        //  AlwaysTemplate 始终根据Tint Color绘制图片，忽略图片的颜色信息。
        childController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: image ?? ""), selectedImage: UIImage(named: selectImage ?? ""))
        childController.tabBarItem.imageInsets=UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        self.addChild(HHNavigationController(rootViewController: childController))
    }
}
