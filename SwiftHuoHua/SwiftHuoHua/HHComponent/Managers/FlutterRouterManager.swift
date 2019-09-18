//
//  FlutterRouterManager.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2019/9/17.
//  Copyright © 2019 White-C. All rights reserved.
//

import Foundation
import flutter_boost

class FlutterRouterManager: NSObject,FLBPlatform {
    let listDetail_URL = "sample://listDetail"
    //实现单例 三步曲
    //1.私有化构造方法
    private override init() {
        
    }
    //2.通过关键字static来保存实例引用
    private static let instance = FlutterRouterManager()
    //3.提供静态访问方法
    public static var sharedRouter: FlutterRouterManager {
        //初始化FlutterBoost
        FlutterBoostPlugin.sharedInstance()?.startFlutter(with: instance, onStart: { (engine) in
            
        })
        return self.instance
    }
    //打开页面
    func open(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        if urlParams["present"] as? Bool == true {
            let vc = FLBFlutterViewContainer()
            vc.setName(url, params: urlParams)
            topVC?.present(vc, animated: true, completion: {
                
            })
        }else {
            
            if listDetail_URL == url {
                let vc = HomeAudioViewController()
                topVC?.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                let vc = FLBFlutterViewContainer()
                vc.hidesBottomBarWhenPushed = true
                vc.setName(url, params: urlParams)
                topVC?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func close(_ uid: String, result: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        let vc = topVC as? FLBFlutterViewContainer
        if (vc is FLBFlutterViewContainer && vc!.name() == uid) {
            vc?.dismiss(animated: true) {
                
            }
        }
        else {
            topVC?.navigationController?.popViewController(animated: true)
        }
    }
}
