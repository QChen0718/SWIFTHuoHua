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
        try? defaultRealm.write {
            defaultRealm.add(student)
        }
        print(defaultRealm.configuration.fileURL ?? "")
    }
    
    /// 保存多个Student
    public class func insertStudents(by students:[Student]) {
        let defaultRealm = getDB()
        //写入添加的学信信息到数据库中
        try? defaultRealm.write {
            defaultRealm.add(students)
            print(defaultRealm.configuration.fileURL ?? "")
        }
    }
    
    /// 获取 所保存的 Studen
    public class func getStudents() -> Results<Student> {
        let defaultRealm = getDB()
        return defaultRealm.objects(Student.self)
    }
    /// 获取 指定id (主键) 的 Student
    public class func getStudent(from id: Int) ->Student? {
        let defaultRealm = getDB()
        
        
        return defaultRealm.object(ofType: Student.self, forPrimaryKey: id)
    }
    /// 获取 指定条件 的 Student
    public class func getStudentByTerm(_ term: String) -> Results<Student> {
        let defaultRealm = getDB()
        print(defaultRealm.configuration.fileURL ?? "")
        let predicate = NSPredicate(format: term)
        // 根据名字升序查询
        let results = defaultRealm.objects(Student.self).sorted(byKeyPath: "id")
        // 根据名字降序序查询
//        let stus = defaultRealm.objects(Student.self).sorted(byKeyPath: "id", ascending: false)
        return results.filter(predicate)
    }
    /// 更新单个 Student
    public class func updateStudent(student: Student) {
        let defaultRealm = getDB()
        try? defaultRealm.write {
            defaultRealm.add(student, update: Realm.UpdatePolicy(rawValue: 1)!)
        }
    }
    /// 更新多个 Student
    public class func updateStudent(students:[Student]) {
        let defaultRealm = getDB()
        try? defaultRealm.write {
            defaultRealm.add(students, update: Realm.UpdatePolicy(rawValue: 1)!)
        }
    }
    /// 更新多个 Student 的年龄
    public class func updateStudentAge(age:Int) {
        let defaultRealm = getDB()
        try? defaultRealm.write {
            let students = defaultRealm.objects(Student.self)
            students.setValue(age, forKey: "age")
        }
    }
    /// 删除单个 Student
    public class func deleteStudent(student: Student) {
        let defaultRealm = getDB()
        try? defaultRealm.write {
            defaultRealm.delete(student)
        }
    }
    /// 删除多个 Student
    public class func deleteStudents(students: Results<Student>) {
        let defaultRealm = getDB()
        try? defaultRealm.write {
            defaultRealm.delete(students)
        }
    }
}
