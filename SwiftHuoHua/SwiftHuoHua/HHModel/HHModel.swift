//
//  HHModel.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/17.
//  Copyright © 2019 White-C. All rights reserved.
//

import Foundation
import HandyJSON

struct HHUser {
    /** 用户ID */
    var user_id: String?
    /** 用户ID */
    var userName: String?
    /** 用户名 */
    var nickName: String?
    /** 密码 */
    var password: String?
    /** 头像 */
    var avatar: String?
    /** 电话 */
    var phonenumber: String?
    /** 生日 */
    var birthday: String?
    /** 性别 */
    var gender: String?
    /** 省份 */
    var province: String?
    /** 城市 */
    var city: String?
    /** 地区 */
    var district: String?
    /** 地址 */
    var address: String?
    /** 组织 */
    var organization: String?
    /** 职位id */
    var  position_id: Int=0
    /** 职位名 */
    var position_name: String?
    /** 信息是否完整 */
    var is_complete: Bool=false
    /** token 用户身份验证信息 */
    var token: String?
    /** 本地存储 邮箱 */
    var user_email: String?
    /** 是否关注 */
    var is_concern: Bool=false
    /** 是否 是大V用户 */
    var  is_v: Int=0
    /** 是否 是游客 */
    var  is_tourist: Int=0
    /** 是否 实名认证 */
    var isVerification: Bool=false;
}
//类方法
class HHUser{
    class func shareUser() -> HHUser  {
        struct Singleton{
            static var onceToke: dispatch_once_t = 0
            static var single:HHUser?
        }
        dispatch_once(&Singleton.onceToke,{
            Singleton.single=share
        })
    }
}

//首页banner模型
struct HomeBannerModel: HandyJSON {
    /** id */
    // 可变类型要给初始值
    var szId: Int = 0
    /** content_id */
    var content_id: Int=0
    /** 业务id */
    var business_id: Int=0
    /** 海报 */
    var poster: String?
    //类型id
    var bannerTypeId: Int=0
    //////////////////////////////////////
    /** 是否关注 */
    var is_concern: Bool=false;
    
    var is_free: Bool=false//是否收费
    var is_list: Bool=false//是否有活动
    var buy_status: Int=0//是否购买
    var is_permission_buy: Bool=false;//是否停止购买
    
    // 直播banner专有
    /** 直播banner中的channel_number */
    var channel_number: String?;
    /** 直播banner中的live_status */
    var living_status: Int=0
    
}

struct ReturnData<T: HandyJSON>: HandyJSON {
    var message:String? //状态消息
    var returnData: T?  //返回内容
    var stateCode: Int = 0 //状态码
    
}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0 //错误码
    var data: ReturnData<T>?
}

