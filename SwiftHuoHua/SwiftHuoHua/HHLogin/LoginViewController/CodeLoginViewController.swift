//
//  CodeLoginViewController.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2019/8/20.
//  Copyright © 2019 White-C. All rights reserved.
//  验证码登录

import UIKit

import RxCocoa
import RxSwift
class CodeLoginViewController: HHBaseViewController {

    //懒加载创建
    //验证码登录
    fileprivate lazy var titlelabel:UILabel = {
       let label = UILabel()
        label.text="验证码登录"
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "262626")
        label.font=UIFont.systemFont(ofSize: 26)
        return label
    }()
    
    fileprivate lazy var phonetextfield:UITextField = {
       let textfiled = UITextField()
        textfiled.placeholder="输入手机号"
        textfiled.font=UIFont.systemFont(ofSize: 15)
        return textfiled
    }()
    
    fileprivate lazy var lineview:UIView = {
       let view = UIView()
        view.backgroundColor=UIColor.hexadecimalColor(hexadecimal: "F5F5F5")
        return view
    }()
    
    fileprivate lazy var checkCodetextfield:UITextField = {
        let textfiled = UITextField()
        textfiled.placeholder="输入验证码"
        textfiled.font=UIFont.systemFont(ofSize: 15)
        return textfiled
    }()
    
    fileprivate lazy var lineview2:UIView = {
        let view = UIView()
        view.backgroundColor=UIColor.hexadecimalColor(hexadecimal: "F5F5F5")
        return view
    }()
    
    fileprivate lazy var getCodeBtn:UIButton = {
       let btn = UIButton(type: .custom)
        btn.setTitle("获取验证码", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    fileprivate lazy var loginBtn:UIButton = {
       let btn = UIButton(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "262626"), for: .normal)
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 18)
        btn.backgroundColor=UIColor.hexadecimalColor(hexadecimal: "E0E0E0")
        return btn
    }()
    
    fileprivate lazy var passwordLoginBtn:UIButton = {
       let btn = UIButton(type: .custom)
        btn.setTitle("密码登录", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "9B9B9B"), for: .normal)
        return btn
    }()
    let disposeBag = DisposeBag()
    var checkname:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //继承父类的设置UI的方法
    override func configUI() {
        
        self.view.addSubview(titlelabel)
        self.view.addSubview(phonetextfield)
        self.view.addSubview(lineview)
        self.view.addSubview(checkCodetextfield)
        self.view.addSubview(lineview2)
        self.view.addSubview(getCodeBtn)
        self.view.addSubview(loginBtn)
        self.view.addSubview(passwordLoginBtn)
        setcontrolSize()
        //按钮点击事件处理方法
        btnAllClick()
        let codevm = CodeLoginViewModel(input: (phone: phonetextfield.rx.text.orEmpty.asDriver(), code: checkCodetextfield.rx.text.orEmpty.asDriver() , login: loginBtn.rx.tap.asSignal()))
        //获得手机号验证返回的内容
        codevm.phonename.drive(onNext: {[weak self] (content) in
            self?.checkname = content
            print("--->",content)
        }).disposed(by: disposeBag)
        //获得验证码验证返回的内容
        codevm.codename.drive(onNext: { (content) in
            self.checkname = content
        }).disposed(by: disposeBag)
        //获得登录按钮是否能点击
        
        codevm.loginTap.drive(onNext: {[weak self] (is_tap) in
            if is_tap {
                //可以点击
                self?.loginBtn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "FFD000")
            }
            else {
                //不能点击
                self?.loginBtn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "E0E0E0")
            }
           self?.loginBtn.isUserInteractionEnabled = is_tap
        }).disposed(by: disposeBag)
    }

    //按钮事件处理统一方法
    func btnAllClick() {
        //登录事件
        loginBtn.rx.tap.subscribe(onNext: {[weak self] () in
            print(self?.checkname ?? "")
        }).disposed(by: disposeBag)
        //密码登录事件
        passwordLoginBtn.rx.tap.subscribe(onNext: {[weak self] () in
           //密码登录按钮事件处理 rx
            self?.navigationController?.pushViewController(LoginViewController(), animated: true)
        }).disposed(by: disposeBag)
        //获取验证码事件
        getCodeBtn.rx.tap.subscribe(onNext: { () in
            print("获取验证码")
        }).disposed(by: disposeBag)
    }
    //设置控件大小
    func setcontrolSize() {
        titlelabel.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.height.equalTo(37)
            make.top.equalTo(4)
        }
        phonetextfield.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(self.view.snp_right).offset(-25)
            make.height.equalTo(70)
            make.top.equalTo(titlelabel.snp_bottom).offset(20)
        }
        lineview.snp.makeConstraints { (make) in
            make.left.right.equalTo(phonetextfield)
            make.top.equalTo(phonetextfield.snp_bottom)
            make.height.equalTo(1)
        }
        checkCodetextfield.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(self.view.snp_right).offset(-105)
            make.height.equalTo(phonetextfield)
            make.top.equalTo(phonetextfield.snp_bottom)
        }
        lineview2.snp.makeConstraints { (make) in
            make.left.right.equalTo(phonetextfield)
            make.top.equalTo(checkCodetextfield.snp_bottom)
            make.height.equalTo(1)
        }
        getCodeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp_right).offset(-25)
            make.size.equalTo(CGSize(width: 90, height: 40))
            make.bottom.equalTo(checkCodetextfield.snp_bottom)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(phonetextfield)
            make.height.equalTo(52)
            make.top.equalTo(checkCodetextfield.snp_bottom).offset(40)
        }
        passwordLoginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.top.equalTo(loginBtn.snp_bottom).offset(30)
            make.height.equalTo(26)
        }
    }
}
