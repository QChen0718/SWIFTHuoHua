//
//  LoginViewModel.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2019/8/23.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
class LoginViewModel {
    typealias responseData = (( _ data:HHUser)->())
    //输入流
    let phoneStr:Variable<String> = .init("")
    let passwordStr:Variable<String> = .init("")
    
    
    //输出流
    let phonename: Driver<String>
    let passwordname: Driver<String>
    let loginTap: Driver<Bool>
    let disposeBag = DisposeBag()
    
    init(input:(phone:Driver<String>,password:Driver<String>,login:Signal<Void>)) {
        phonename = input.phone.flatMapFirst({ (str) in
            if str.isEmpty {
                return .just("手机号不能为空")
            }
            else if str.count < 11 {
                return .just("请输入正确的手机号")
            }
            else {
                return .just(str)
            }
        })
        passwordname = input.password.flatMapFirst({ (str) in
            if str.isEmpty {
                return .just("密码不能为空的")
            }
            else if str.count < 6 {
                return .just("密码不能小于6位数")
            }
            else {
                return .just(str)
            }
        })
        loginTap = Driver.combineLatest(phonename,passwordname){
            phones,passwoeds in
            if phones.count == 11 && passwoeds.count == 6 {
                return true
            }else {
                return false
            }
        }.distinctUntilChanged()
        
        
    }
    open func loginClick(succeckData:@escaping responseData){
        ApiLoadingProvider.request(.passwordLogin(phone: phoneStr.value, password: passwordStr.value.sha256String), model: HHUser.self) { (returnData, errnocode) in
            if errnocode==0
            {
                succeckData(returnData ?? HHUser())
            }
        }
    }
}
