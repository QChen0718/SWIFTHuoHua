//
//  HHHTTPService.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/17.
//  Copyright © 2019 White-C. All rights reserved.
//

import Moya
import MBProgressHUD
import HandyJSON
import SwiftyJSON

//网络活动插件
let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else {return}
    switch type {
    case .began:
        MBProgressHUD.hide(for: vc.view, animated: false)
        MBProgressHUD.showAdded(to: vc.view, animated: true)
        print("开始网络请求")
        
    case .ended:
        MBProgressHUD.hide(for: vc.view, animated: true)
        print("网络请求结束")
    }
}

//超时关闭
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<HHApi>.RequestResultClosure) -> Void in
    if var urlRequest = try? endpoint.urlRequest() {
        //设置超时时长
        urlRequest.timeoutInterval = 20
        //成功
        closure(.success(urlRequest))
    }else{
        //失败
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}
//无加载指示器的
let ApiProvider = MoyaProvider<HHApi>(requestClosure: timeoutClosure)
//有加载指示器的
let ApiLoadingProvider = MoyaProvider<HHApi>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

enum HHApi {
    case loadHomeBanner //首页banner
    case loadHomeCircleList(page:Int) //首页帖子列表
    case loadHomeAudio// 首页推荐音频
    case passwordLogin(phone:String?,password:String?) //密码登录
}

extension HHApi: TargetType {
    var baseURL: URL {
        switch self {
        case .loadHomeAudio:
            return URL(string: "http://apiaudiotest.huohuacity.com/")!
        default:
            return URL(string: "http://api.huohuacity.com/")!
        }
    }
    //请求路径
    var path: String {
        switch self {
        case .loadHomeBanner:
            return "home/home/banner"
        case .loadHomeAudio:
            return "audio/list.do"
        case .loadHomeCircleList:
            return "circle/bar/postrecommend"
        case .passwordLogin:
            return "account/baseuser/login"
        }
    }
    //请求类型
    var method: Moya.Method {
        return .post
    }
    //请求数据
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    //请求参数
    var task: Task {
        var parmeters:[String:Any] = [:]
        
        switch self {
        case .loadHomeAudio:
            parmeters["pageNum"]=0
            parmeters["pageSize"]=3
        case .loadHomeCircleList(let page):
            parmeters["page"] = max(1, page)
            parmeters["pagesize"] = 25
        case .passwordLogin(let phone, let password):
            parmeters["phonenumber"] = phone
            parmeters["password"] = password
        default: break
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    ///请求头
    var headers: [String : String]? {
        return ["version":Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String,"encrypttype":"1","token":HHUser.user()!.token!]
    }
}

//解析响应的数据转换成模型
extension Response {
    //throws 方法抛出异常
    func mapModel<T:HandyJSON>(_ type: T.Type) throws -> T {
        //响应返回的二进制数据转换成字符串
        let jsonString = String(data:data, encoding: .utf8)
        //转换成模型
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            //抛出解析异常
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

extension MoyaProvider {
    //当有返回值的方法未得到接收和使用会有警告 ， @discardableResult 消除警告
    @discardableResult
    //扩展添加请求方法
    
    /// 网络加载方法
    ///
    /// - Parameters:
    ///   - target:
    ///   - model: 模型
    ///   - completion: 请求到的数据 闭包接收
    /// - Returns: 返回请求数据
    open func request<T:HandyJSON>(_ target:Target , model: T.Type, completion:((_ returnData: T?,_ errnoCode: Int) -> Void)?) -> Cancellable? {
        //网络请求
        return request(target, completion: { (result) in
            //解析请求的数据
            guard let completion = completion else { return }
            guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                completion(nil, 0)
                return
            }
            completion(returnData.msg,returnData.errno)
        })
    }
}
