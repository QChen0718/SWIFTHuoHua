//
//  HHHTTPService.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/17.
//  Copyright © 2019 White-C. All rights reserved.
//

import Moya
import MBProgressHUD

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
        default: break
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    ///请求头
    var headers: [String : String]? {
        return ["version":Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String,"encrypttype":"1"]
    }
}
