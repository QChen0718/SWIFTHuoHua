//
//  HHCircleVC.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/8/4.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHCircleVC: HHBaseViewController {

    fileprivate lazy var button: UIButton = {
       let btn = UIButton(type: .custom)
        btn.setTitle("添加", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        return btn
    }()
    fileprivate lazy var searchbutton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("查询", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        return btn
    }()
    fileprivate lazy var updatebutton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("修改", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        return btn
    }()
    fileprivate lazy var deletebutton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("删除", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        return btn
    }()
    fileprivate lazy var corverimageview: UIImageView = {
       let imageview = UIImageView()
        return imageview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func configUI() {
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        self.view.addSubview(searchbutton)
        searchbutton.snp.makeConstraints { (make) in
            make.centerX.size.equalTo(self.button)
            make.top.equalTo(self.button.snp_bottom).offset(20)
        }
        self.view.addSubview(corverimageview)
        corverimageview.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalTo(self.searchbutton.snp_bottom).offset(20)
        }
        self.view.addSubview(updatebutton)
        updatebutton.snp.makeConstraints { (make) in
            make.centerX.size.equalTo(self.searchbutton)
            make.top.equalTo(self.searchbutton.snp_bottom).offset(20)
        }
    }
}

extension HHCircleVC {
    @objc func btnClick(btn:UIButton)
    {
        switch btn.titleLabel?.text {
        case "添加":
            insertStudentWithPhotoData()
        case "查询":
//            searchStudentData()
            searchStudentByID()
        case "修改":
            updateStudentsAge()
        case "删除":
            deleteOneStudent()
        default:
            break
        }
//        inserStudentData()
//        insertStudentWithPhotoData()
        
    }
    //插入一条数据到数据库中
    public func inserStudentData() {
        let stu = Student()
        stu.name = "钬花-White"
        stu.age = 28
        stu.id = 10030
        
        let birthdayStr = "1992-08-18"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        stu.birthday = dateFormatter.date(from: birthdayStr)! as NSDate
        stu.height = 180
        stu.address = "浦东新区"
        HHSQLRealmTool.insertStudent(by: stu)
    }
    //测试在数据库中插入一个拥有多本书并且有头像的学生对象
    
    public func insertStudentWithPhotoData() {
        let stu = Student()
        stu.name = "钬花-White-有头像"
        stu.age = 25
        stu.height = 175
        stu.id = 10032
        let birthdayStr = "1992-08-18"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        stu.birthday = dateFormatter.date(from: birthdayStr)! as NSDate
        stu.address = "浦东新区"
        //头像
        stu.setPhotoWithName(name: "blank_noNetwork")
        let bookFubaba = HHSQLModel.init(name: "富爸爸穷爸爸", author: "[美]罗伯特.T.清崎")
        let bookShengmingbuxi = HHSQLModel.init(name: "生命不息, 折腾不止", author: "罗永浩")
        let bookDianfuzhe = HHSQLModel(value: ["颠覆着: 周鸿祎自传","周鸿祎"])
        stu.HHUsers.append(bookFubaba)
        stu.HHUsers.append(bookShengmingbuxi)
        stu.HHUsers.append(bookDianfuzhe)
        HHSQLRealmTool.insertStudent(by: stu)
    }
    
    public func insertStudentsData() {
        //定义可变数组
        var stus = [Student]()
        for i in 1...44 {
            let stu = Student()
            stu.name = "钬花-White-\(i)"
            stu.age = 25
            stu.height = 175
            stu.id = 10031+i
            let birthdayStr = "1992-08-18"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            stu.birthday = dateFormatter.date(from: birthdayStr)! as NSDate
            stu.address = "浦东新区"
            stus.append(stu)
        }
        HHSQLRealmTool.insertStudents(by: stus)
    }
    
//    2.1 普通查询： 查询数据库中所有学生模型并输出姓名，图片，所拥有的书信息
    public func searchStudentData() {
        let stus = HHSQLRealmTool.getStudents()
        for stu in stus {
            print(stu.name)
            if stu.photo != nil
            {
                self.corverimageview.image = stu.getPhotoImage()
            }
            if stu.HHUsers.count > 0 {
                for user in stu.HHUsers
                {
                    print(user.name + "+" + user.author)
                }
            }
        }
    }
//    2.2 主键查询： 查询数据库中id 为 110 的学生模型并输出姓名
    // 通过主键查询
    public func searchStudentByID() {
        let stu = HHSQLRealmTool.getStudent(from: 10030)
        if let student = stu {
            print(student.name)
        }
    }
    
//    2.3 主键查询： 查询数据库中name 为 钬花-White 的学生模型并输出姓名
    
    public func searchNameStudent() {
        let students = HHSQLRealmTool.getStudentByTerm("钬花-White")
        if students.count == 0 {
            print("未查询到任何数据")
            return
        }
        for student in students {
            print(student.name,student.height)
        }
    }
    //批量更改
    public func updateStudents() {
        var stus = [Student]()
        for i in 1...44 {
            let stu = Student()
            stu.name = "钬花改名-White-\(i)"
            stu.id = 10031+i
            stu.age = 30
            stus.append(stu)
        }
        HHSQLRealmTool.updateStudent(students: stus)
    }
    //批量更改年龄
    public func updateStudentsAge() {
        HHSQLRealmTool.updateStudentAge(age: 18)
    }
    /// 删除id 为 10033 的学生
    public func deleteOneStudent() {
        let stu = HHSQLRealmTool.getStudent(from: 10033)
        if stu != nil {
            HHSQLRealmTool.deleteStudent(student: stu!)
        }
    }
    /// 删除所有
    public func deleteAllStudent() {
        let stus = HHSQLRealmTool.getStudents()
        HHSQLRealmTool.deleteStudents(students: stus)
        
    }
}
