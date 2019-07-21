//
//  HHNavigationController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/16.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //返回手势
        guard let interactionGes = interactivePopGestureRecognizer else {return}
        //获取当前返回的视图view
        guard let targetView = interactionGes.view else {return}
        //获取当前返回视图的tag值
        guard let internalTargets = interactionGes.value(forKeyPath: "targets") as? [NSObject] else {return}
        ////获取第一个tag值
        guard let internalTarget = internalTargets.first?.value(forKey: "target") else { return }
        // 系统返回方法
        let action = Selector(("handleNavigationTransition:"))
        let fullScreenGesture = UIPanGestureRecognizer(target: internalTarget, action: action)
        fullScreenGesture.delegate=self
        //给当前的view添加滑动手势
        targetView.addGestureRecognizer(fullScreenGesture)
        interactionGes.isEnabled = false
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count>0 {
            //隐藏标签栏
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension HHNavigationController : UIGestureRecognizerDelegate{
    //手势即将开始滑动的时候
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        //从左到右滑动
        let lefttoRight = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
        //判断是否是滑动手势
        guard let ges = gestureRecognizer as? UIPanGestureRecognizer else {
            return true
        }
        //如果不是从左到右滑动就返回false
        if ges.translation(in: gestureRecognizer.view).x * (lefttoRight ? 1 : -1) <= 0 || disablePopGesture{
            return false
        }
        //控制器个数为1时是跟控制器
        return viewControllers.count != 1
    }
}
enum UNavigationBarStyle {
    case theme ///有图片背景的
    case clear ///透明的
    case white ///白色的
}
extension UINavigationController{
    private struct AssociatedKeys {
        static var disablePopGesture: Void?
    }
    // 禁用返回手势
    var disablePopGesture: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.disablePopGesture) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.disablePopGesture, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func navigationbarStyle(_ style:UNavigationBarStyle) {
        switch style {
        case .theme:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(named: ""), for: .default)
            navigationBar.shadowImage=UIImage()
        case .clear:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .white:
            navigationBar.barStyle = .default
            navigationBar.setBackgroundImage(UIColor.white.image(), for:.default)
            navigationBar.shadowImage = UIImage()
        }
    }
}
