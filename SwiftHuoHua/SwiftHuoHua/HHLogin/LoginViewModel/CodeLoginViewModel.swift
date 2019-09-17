//
//  CodeLoginViewModel.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2019/8/20.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
class CodeLoginViewModel {
    //闭包
    typealias reposeData = ((_ userinfo:HHUser) -> ())
    
    //输出流
    let phonename: Driver<String>
    let codename: Driver<String>
    let loginTap: Driver<Bool>
    
    let disposeBag = DisposeBag()
    
    let phoneNumber:String
    
    init(input:
        (phone:Driver<String>,
        code:Driver<String>,
        login:Signal<Void>),phoneStr:String) {
        
        phonename = input.phone.flatMapLatest({ (str) in
            if str.isEmpty {
                return .just("手机号不能为空")
            }
            else if str.count != 11
            {
                return .just("请输入正确的手机号")
            }
            else {
                return .just(str)
            }
        })
        codename = input.code.flatMapLatest({ (str) in
            if str.isEmpty {
                return .just("验证码不能为空")
            }
            else {
                return .just(str)
            }
        })
        
        //登录按钮是否可用
        
        loginTap = Driver.combineLatest(
            phonename,codename)
             { username , code in
                if username.count == 11 && code.count == 6
                {
                    return true
                }else {
                    return false
                }
        }.distinctUntilChanged()
        
        phoneNumber = phoneStr
    }
    //获取验证码网络请求方法
    open func getCodeClick(repose:@escaping reposeData) {
        ApiLoadingProvider.request(.getcodeLogin(phone: phoneNumber), model: HHUser.self) { (returnData,errnocode) in
            if errnocode == 0 {
                //请求成功
                repose(returnData!)
            }
        }
    }
}
