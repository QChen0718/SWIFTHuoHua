//
//  HHVCManager.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2020/3/13.
//  Copyright © 2020 White-C. All rights reserved.
//  控制器跳转的统一管理

import UIKit

class HHVCManager: NSObject {
     var globalNavController:UINavigationController!
    public static let sharedInstance = HHVCManager()
//    获取最顶上的view
    class func getTopView() -> UIView{
        return sharedInstance.globalNavController.view
    }
    //设置跟控制器，这个方法获得到了
    class func setRootVC(_ rootVC:UINavigationController){
        sharedInstance.globalNavController = rootVC
        sharedInstance.globalNavController.navigationBar.isHidden = true
        UIApplication.shared.delegate?.window??.rootViewController = HHVCManager.sharedInstance.globalNavController
    }
    // 跳转到主页面
    class func gotoMainController(){
        let vc:UITabBarController? = HHVCManager.sharedInstance.globalNavController.viewControllers.first as? UITabBarController
        sharedInstance.globalNavController.dismiss(animated: true, completion: nil)
        sharedInstance.globalNavController.popToRootViewController(animated: true)
        if let newvc = vc {
            for nav in newvc.viewControllers! {
                if nav is UINavigationController {
                    (nav as? UINavigationController)?.popToRootViewController(animated: true)
                }
            }
        }
    }
    class func getMainController() -> UITabBarController?{
        return HHVCManager.sharedInstance.globalNavController.viewControllers.first as? UITabBarController
    }
    //获取最上面的控制器
    open class func getTopVC() -> UIViewController? {
        return getCurrentNav()?.viewControllers.last
    }
    //获取当前控制器
    open class func getCurrentVC() -> UIViewController?{
        return getCurrentNav()?.visibleViewController
    }
    //获取当前导航栏
    class func getCurrentNav() -> UINavigationController? {
        if let nav = sharedInstance.globalNavController.presentedViewController as? UINavigationController {
            return nav
        }
        let vc = sharedInstance.globalNavController.viewControllers.first
        if let mainTabBarVC = vc as? UITabBarController {
            let nav = mainTabBarVC.viewControllers?[mainTabBarVC.selectedIndex] as? UINavigationController
            return nav
        }else{
            return sharedInstance.globalNavController
        }
    }
}

// present&dismiss
extension HHVCManager{
    public class func presentToView(_ targetVC:UIViewController,animated:Bool = true,modalPresentationStyle:UIModalPresentationStyle = .fullScreen,completion:(()->Void)? = nil){
        let vc = sharedInstance.globalNavController
        if #available(iOS 13.0, *){
            targetVC.modalPresentationStyle = modalPresentationStyle
        }
        vc?.present(targetVC, animated: animated, completion: completion)
    }
    public class func dismissView(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        
        let vc = sharedInstance.globalNavController
        vc?.dismiss(animated: animated, completion: completion)
    }
}
