//
//  AppDelegate.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/15.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
import RealmSwift
import flutter_boost
@UIApplicationMain
class AppDelegate: FLBFlutterAppDelegate {

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor=UIColor.white;
        window?.makeKeyAndVisible()
        AppDelegate.configRealm()
        setRootViewController()
        return true
    }
    
    func setRootViewController()  {
        if (HHUser.user()?.token) != nil  {
            //直接进入首页
           let nvc = HHTabBarController()
            window?.rootViewController=nvc
        }else {
            //进入登录页面
           let nvc = HHNavigationController(rootViewController: CodeLoginViewController())
            nvc.navigationbarStyle(.white)
            window?.rootViewController=nvc
        }
    }
    ///配置数据库
    public class func configRealm() {
        /// 如果要存储的数据模型属性发生变化，需要配置当前版本号比之前大
        let dbVersion: UInt64 = 5
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/defaultDB.realm")
        let config = Realm.Configuration(fileURL: URL.init(string: dbPath), readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldSchemaVersion) in
            
        }, deleteRealmIfMigrationNeeded: false)
        
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (realm, error) in
            if let _ = realm {
                print("Realm 数据库配置成功！")
            } else if let error = error {
                print("Realm 数据库配置失效：\(error.localizedDescription)")
            }
        }
        
    }
    override func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    override func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    override func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    override func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

