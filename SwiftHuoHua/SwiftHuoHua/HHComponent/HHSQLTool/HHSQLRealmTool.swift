//
//  HHSQLRealmTool.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/8/4.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
import RealmSwift

class HHSQLRealmTool: Object {
    private class func getDB() -> Realm {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/defaultDB.realm")
        ///传入路径会自动创建数据库
        let defaultRealm = try! Realm(fileURL: URL.init(string: dbPath)!)
        return defaultRealm
    }
}

//増
extension HHSQLRealmTool {
    //添加一个学生信息
    public class func insertStudent(by student : Student) {
        let defaultRealm = getDB()
        //写入添加学生信息到数据库
        try! defaultRealm.write {
            defaultRealm.add(student)
        }
        print(defaultRealm.configuration.fileURL ?? "")
    }
    
    /// 保存多个Student
    public class func insertStudents(by students:[Student]) {
        let defaultRealm = getDB()
        //写入添加的学信信息到数据库中
        try! defaultRealm.write {
            defaultRealm.add(students)
            print(defaultRealm.configuration.fileURL ?? "")
        }
    }
    
    /// 获取 所保存的 Studen
    public class func getStudents() -> Results<Student> {
        let defaultRealm = getDB()
        return defaultRealm.objects(Student.self)
    }
}
