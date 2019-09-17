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

let kH5CommentUrl = "https://www.huohuacity.com"
let kAudioBannerListUrl = "audio/audioBannerList"    //音频首页Banner
let kExcerptList = "audio/excerptList"       //音频节选区域
let kAudioBoutiqueList = "audio/audioBoutiqueList" //钬花精品课列表
let kAudioWWECList = "audio/audioWWECList"     //WWEC精选演讲
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
    case getcodeLogin(phone:String?)//获取验证码
    case loadHomeAudioList(pageNum:Int, pageSize:Int) //音频列表
    case loadAudiodirectory(id: Int) //音频目录
    case loadHomeLive(pageNum: Int) //首页直播
    case loadAudioBannerList //音频首页banner
    case loadAudioExcerptList(id: Int) //音频首页每日精选
    case loadAudioSelectAudioList //音频首页精品课程
    case loadWWECDataList //音频首页WWEC大会精选
}

extension HHApi: TargetType {
    var baseURL: URL {
        switch self {
        case .loadHomeAudio , .loadHomeAudioList, .loadAudiodirectory, .loadHomeLive, .loadAudioBannerList, .loadAudioExcerptList, .loadAudioSelectAudioList, .loadWWECDataList:
            return URL(string: "http://apiaudio.huohuacity.com/")!
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
        case .getcodeLogin:
            return "common/sms/sendsmscrypt"
        case .loadHomeAudioList:
            return "audio/list.do"
        case .loadAudiodirectory:
            return "audio/item.do"
        case .loadHomeLive:
            return "huohuacity/live/getLives"
        case .loadAudioBannerList:
            return kAudioBannerListUrl
        case .loadAudioExcerptList:
            return kExcerptList
        case .loadAudioSelectAudioList:
            return kAudioBoutiqueList
        case .loadWWECDataList:
            return kAudioWWECList
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
        case .getcodeLogin(let phone):
            parmeters["phonenumber"] = phone
            parmeters["app"] = "huohua"
            parmeters["uuid"] = UIDevice.current.identifierForVendor?.uuidString
        case .loadHomeAudioList(let pageNum, let pageSize):
            parmeters["pageNum"] = pageNum
            parmeters["pageSize"] = pageSize
        case .loadAudiodirectory(let id):
            parmeters["id"] = id
            parmeters["pageNum"]=0
            parmeters["pageSize"]=50
        case .loadHomeLive(let pageNum):
            parmeters["pageNum"] = pageNum
            parmeters["pageSize"] = 10
        case .loadAudioExcerptList(let id):
            parmeters["id"] = id
        default: break
            
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    ///请求头
    var headers: [String : String]? {
        return ["version":Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String,"encrypttype":"1","token":HHUser.user()?.token ?? ""]
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
    
    
    open func newrequest<T:HandyJSON>(_ target:Target, model: T.Type ,completion:@escaping ((_ returnData:T)->Void)) -> Cancellable {
        return request(target, completion: { (result) in
            switch result {
            case .success(let response):
                let jsonStr = String(data: response.data, encoding: .utf8)
                let returndata = model.deserialize(from: jsonStr, designatedPath: "msg")
                
                completion(returndata!)
            case .failure(let error):
                print("error = %@",error)
            }
        })
    }
}

