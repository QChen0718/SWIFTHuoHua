//
//  LoginViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/17.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
class LoginViewController: HHBaseViewController {
    //懒加载textfield
    fileprivate lazy var titlelabel:UILabel = {
        let label = UILabel()
        label.text="密码登录"
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "262626")
        label.font=UIFont.systemFont(ofSize: 26)
        return label
    }()
    
    fileprivate lazy var phoneTextfield:UITextField = {
        let textfield = UITextField()
        textfield.font=UIFont.systemFont(ofSize: 15)
        textfield.textColor=UIColor.black
        textfield.placeholder="请输入手机号"
        return textfield
    }()
    fileprivate lazy var lineview:UIView = {
        let view = UIView()
        view.backgroundColor=UIColor.hexadecimalColor(hexadecimal: "F5F5F5")
        return view
    }()
    fileprivate lazy var passwordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 15)
        textfield.textColor = UIColor.black
        textfield.placeholder="请输入密码"
        return textfield
    }()
    fileprivate lazy var lineview2:UIView = {
        let view = UIView()
        view.backgroundColor=UIColor.hexadecimalColor(hexadecimal: "F5F5F5")
        return view
    }()
    fileprivate lazy var loginBtn: UIButton = {
       let btn = UIButton(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor=UIColor.hexadecimalColor(hexadecimal: "E0E0E0")
        btn.layer.cornerRadius=5
        return btn
    }()
    fileprivate lazy var checkCodeLoginBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("验证码登录", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "9B9B9B"), for: .normal)
        return btn
    }()
    let disposeBag = DisposeBag()
    var passwordvm:LoginViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func configUI() {
        super.configUI()
        self.view.addSubview(self.titlelabel)
        self.view.addSubview(self.phoneTextfield)
        self.view.addSubview(self.lineview)
        self.view.addSubview(self.passwordTextfield)
        self.view.addSubview(self.lineview2)
        self.view.addSubview(self.loginBtn)
        self.view.addSubview(self.checkCodeLoginBtn)
        passwordvm = LoginViewModel(input: (phone: self.phoneTextfield.rx.text.orEmpty.asDriver(), password: self.passwordTextfield.rx.text.orEmpty.asDriver(),login:loginBtn.rx.tap.asSignal()))
        passwordvm?.loginTap.drive(onNext: { (is_tap) in
            if is_tap {
                //可以点击
                self.loginBtn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "FFD000")
            }else {
                //不可以点击
                self.loginBtn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "E0E0E0")
            }
            self.loginBtn.isUserInteractionEnabled=is_tap
        }).disposed(by: disposeBag)
        
        setupUI()
        //按钮点击事件处理方法
        btnAllClick()
    }
    func btnAllClick()  {
        loginBtn.rx.tap.subscribe(onNext: {[weak self] () in
            self?.passwordvm?.phoneStr.value = self?.phoneTextfield.text ?? ""
            self?.passwordvm?.passwordStr.value = self?.passwordTextfield.text ?? ""
            self?.passwordvm?.loginClick(succeckData: { (user) in
                //服务器返回成功
                //归档保存
                HHUser.save(user: user)
                if UIApplication.shared.keyWindow?.rootViewController as? HHTabBarController != nil {
                    //是否隐藏返回按钮
                    self?.dismiss(animated: true, completion: nil)
                }else {
                    self?.view.window?.rootViewController=HHTabBarController()
                }
            })
        }).disposed(by: disposeBag)
        //验证码登录
        checkCodeLoginBtn.rx.tap.subscribe(onNext: {[weak self] () in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    func setupUI() {
        titlelabel.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.height.equalTo(37)
            make.top.equalTo(4)
        }
        phoneTextfield.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(self.view.snp_right).offset(-25)
            make.height.equalTo(70)
            make.top.equalTo(titlelabel.snp_bottom).offset(20)
        }
        lineview.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTextfield)
            make.top.equalTo(phoneTextfield.snp_bottom)
            make.height.equalTo(1)
        }
        passwordTextfield.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(self.view.snp_right).offset(-105)
            make.height.equalTo(phoneTextfield)
            make.top.equalTo(phoneTextfield.snp_bottom)
        }
        lineview2.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTextfield)
            make.top.equalTo(passwordTextfield.snp_bottom)
            make.height.equalTo(1)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTextfield)
            make.height.equalTo(52)
            make.top.equalTo(passwordTextfield.snp_bottom).offset(40)
        }
        checkCodeLoginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.top.equalTo(loginBtn.snp_bottom).offset(30)
            make.height.equalTo(26)
        }
    }
}

extension HHBaseViewController
{
    
}
