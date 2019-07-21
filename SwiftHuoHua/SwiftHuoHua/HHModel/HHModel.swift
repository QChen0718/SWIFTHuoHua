//
//  HHModel.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/17.
//  Copyright © 2019 White-C. All rights reserved.
//

import Foundation
import HandyJSON


//类方法

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
//根 最外层的字段
struct ResponseData<T: HandyJSON>: HandyJSON {
    var errno: Int = 0 //错误码
    var msg: T?
}

