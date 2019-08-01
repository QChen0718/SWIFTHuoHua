//
//  LoginViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/17.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: HHBaseViewController {
    //懒加载textfield
    fileprivate lazy var phoneTextfield:UITextField = {
        let textfield = UITextField()
        textfield.font=UIFont.systemFont(ofSize: 15)
        textfield.textColor=UIColor.black
        textfield.placeholder="请输入手机号"
        textfield.text="18311055781"
        return textfield
    }()
    fileprivate lazy var passwordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 15)
        textfield.textColor = UIColor.black
        textfield.placeholder="请输入密码"
        textfield.text="cq0718"
        return textfield
    }()
    fileprivate lazy var loginBtn: UIButton = {
       let btn = UIButton(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        btn.layer.cornerRadius=5
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
    }
    override func configUI() {
        self.view.addSubview(self.phoneTextfield)
        self.view.addSubview(self.passwordTextfield)
        self.view.addSubview(self.loginBtn)
        setupUI()
    }
    func setupUI() {
        phoneTextfield.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(self.view.snp_right).offset(-15)
            make.height.equalTo(40)
            make.top.equalTo(40)
        }
        passwordTextfield.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(phoneTextfield)
            make.top.equalTo(phoneTextfield.snp_bottom).offset(10)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 35))
        }
    }
    @objc func btnClick(_ btn:UIButton) {
        
        ApiLoadingProvider.request(.passwordLogin(phone: phoneTextfield.text, password: passwordTextfield.text?.sha256String), model: HHUser.self) {[weak self] (returnData,errnocode) in
            if errnocode==0
            {
                //服务器返回成功
                //归档保存
              HHUser.save(user: returnData ?? HHUser())
              self?.view.window?.rootViewController=HHTabBarController()
            }
            else
            {
                
            }
            
        }
    }
}

extension HHBaseViewController
{
    
}
