//
//  HHSaveTool.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/31.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHSaveTool {
    //存储
    class func setNormalDefault(key: String, value: AnyObject?) {
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        }
        else{
            UserDefaults.standard.set(value, forKey: key)
            //同步
            UserDefaults.standard.synchronize()
        }
    }
    
    //通过对应的key移除存储
    class func removeNormalUserDefault(key: String?) {
        if key != nil {
            UserDefaults.standard.removeObject(forKey: key!)
            UserDefaults.standard.synchronize()
        }
    }
    
    //通过key找到储存的value
    class func getNormalDefult(key:String) -> AnyObject? {
        return UserDefaults.standard.value(forKey: key) as AnyObject?
    }
    
    
    /// 创建文件
    ///
    /// - Parameters:
    ///   - name: 文件名
    ///   - fileBaseUrl: url
    /// - Returns: 文件路径
    class func creatNewFiles(name: String, fileBaseUrl: NSURL) -> String {
        let manager = FileManager.default
        let file = fileBaseUrl.appendingPathComponent(name)
        let exist = manager.fileExists(atPath: (file?.path)!)
        if !exist {
            let createFilesSuccess = manager.createFile(atPath: (file?.path)!, contents: nil, attributes: nil)
            print("文件创建结果: \(createFilesSuccess)")
        }
        return file?.absoluteString ?? ""
    }
    
    /// 读取文件
    ///
    /// - Parameters:
    ///   - name: 文件名
    ///   - fileBaseUrl: url
    /// - Returns: 读取数据
    class func readTheFiles(name: String, fileBaseUrl: NSURL) -> String {
        let file = fileBaseUrl.appendingPathComponent(name)
        let readHandler = try! FileHandle(forReadingFrom: file!)
        let data = readHandler.readDataToEndOfFile()
        let readString = String(data: data, encoding: .utf8)
        return readString ?? ""
    }
    
}
