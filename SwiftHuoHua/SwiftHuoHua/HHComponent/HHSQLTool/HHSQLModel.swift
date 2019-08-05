//
//  HHSQLModel.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/8/4.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class HHSQLModel: Object {
    //名称
    @objc dynamic var name = ""
    //作者
    @objc dynamic var author = ""
    /// LinKingObjects 反向表示该对象的拥有者
    let owenrs = LinkingObjects(fromType: Student.self, property: "HHUsers")
    //自定义初始化方法
    convenience init(name:String,author:String) {
        self.init()
        self.name = name
        self.author = author
    }
   convenience init (value array: [String]) {
        self.init()
        self.name = array[0]
        self.author = array[1]
    }
}

class Student: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 18
    @objc dynamic var height = 172
    @objc dynamic var id = 0
    @objc dynamic var address = ""
    @objc dynamic var birthday : NSDate? = nil
    @objc dynamic var photo: NSData? = nil
    
    //重写 Object.primaryKey() 可以设置模型的主键。
    //声明主键之后，对象将被允许查询，更新速度更加高效，并且要求每个对象保持唯一性。
    //一旦带有主键的对象被添加到 Realm 之后，该对象的主键将不可修改。
    override static func primaryKey() -> String? {
        //指定那个键为主键
        return "id"
    }
    
    //重写 Object.ignoredProperties() 可以防止 Realm 存储数据模型的某个属性
    override static func ignoredProperties() -> [String] {
        //过滤一些不需要存储的属性
        return ["tempID"]
    }
    //重写 Object.indexedProperties() 方法可以为数据模型中需要添加索引的属性建立索引，Realm 支持为字符串、整型、布尔值以及 Date 属性建立索引。
    override static func indexedProperties() -> [String] {
        return ["name"]
    }
    //List 用来表示一对多的关系：一个 Student 中拥有多个 Book。
    let HHUsers = List<HHSQLModel>()
    
    //设置头像方法
    public func setPhotoWithName(name:String) {
        //将图片转换成NSData
        self.photo = UIImage(named: name)!.pngData() as NSData?
    }
    //获取头像方法
    public func getPhotoImage() -> UIImage {
        let image = UIImage(data: self.photo! as Data)
        return image ?? UIImage()
    }
}
