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
enum HHHomeType: Int, HandyJSONEnum {
    case banner = 0
    case audio
    case circle
}

//首页banner模型

struct audiobannerListModel: HandyJSON {
    var list: [HomeBannerModel]?
}

struct HomeBannerModel: HandyJSON {
    
    /** id */
    // 可变类型要给初始值
    var hometype: HHHomeType = .banner
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

//首页推荐帖子模型
struct homeCircleListModel: HandyJSON {
    var list: [homeCircleModel]?
}
struct homeCircleModel: HandyJSON {
    var hometype: HHHomeType = .circle
    var cellHeight: Float = 0.0
    var id: String? //动态Id,帖子Id
    var avatar: String? //头像
    
    var nickname: String? //昵称
    var username: String? //真实姓名
    var publish_at: String? //发布时间
    var is_secret: Bool = false //is_secret = true 为私密讨论组
    /*-------------*/
    var address: String? //课件PPT的地址
    var fileType: String? //课件文件类型 ： 1图片，2pdf，3ppt
    /*-------------*/
    
    var is_user_secret: Bool = false//用户是否属于私密讨论组
    var createAt: String? // 创建时间
    var updateAt: String?//更新时间
    var title: String?//标题
    var sz_descr: String?//描述
    var poster: String?//大V封面海报
    var image: String?//封面海报
    var posters:[String?]?//图像Url数组
    var is_approval:Bool = false//是否点赞
    var approvalcount:String? //点赞数
    var commentcount: String? //评论数
    var readcount: String?//浏览数
    var is_favorite: Bool=false//是否收藏
    var parent_circle_id: Int = 0
    var parent_circle_name:String? //一级圈子名称
    var circle_id: Int = 0//圈子ID,标签ID
    var circle_name: String? //圈子名称,日志标签名称
    var organization: String?//机构名称
    var talk_name: String?//标签名称
    var talk_id: Int = 0//讨论组ID
    var favoritecount: String?//收藏个数
    var is_anonymous: Bool = false//是否匿名
    var is_comment: Bool = false//是否评论
    var is_concern: Bool = false//是否关注
    var is_publish: String?// 0审核中 1审核通过 2拒绝
    var is_talk_publish: Bool = false//讨论组是否被下架 0下架
    
    var is_top: Bool = false//是否精华帖
    var is_spacial: Bool = false//是否是特殊讨论组
    var is_user_manager: Bool = false//true 是管理员  false 不是管理员
    var is_fans: Bool = false//粉丝
    var is_followed: Bool = false//已关注
    var is_tourist: Bool = false//是否是游客
    var isReview: Int = 0//审核状态 0 审核中   1 审核通过   2 未过审
    var post_content_id: Int = 0//发布id
    var post_type_id: Int = 0//帖子类型id
    var sharecount: Int = 0//分享个数
    var top_at: String?//精华帖时间
    var user_id: String?//用户ID
    var isV: Bool = false//是否大V
    var is_v: Bool = false//是否大V
    var isSilence: Bool = false//该用户是否被 该小组 屏蔽
    var isQuit: Bool = false//该用户是否退出该小组
    
    var pendant: String?//用户头饰
    
    var is_social: Bool = false//判断是社区发帖还是文章发帖
    var v_introduction: String?//kol描述
    var post_image: String?//文章 图片  1.5.4版本添加
    var type: String? //0 普通帖子  1文章帖子  2 问答
    ///////// 添加 ///////
    var is_hiddenLine: Bool = false//是否显示下划线  置顶帖中使用
    /** cell高度 */
    var cell_height: Float = 0.0
    
//    var talks:[Any]？//
//
//    var tags:[Any]？//文章标签数组
//
//    var approval_list:[Any]？//点赞人数数组
}

//首页音频
struct homeAudioListModel: HandyJSON {
    var list: [homeAudioModel]?
    
}

//音频每日精选
struct excerptListModel: HandyJSON {
    var list: homeAudioModel?
    
}
//音频详情模型
struct homeAudioModel: HandyJSON {
    var hometype: HHHomeType = .audio
    var items: [audiodirectoryModel]?
    var applePayPriceId: Int = 0
    var count: String?
    var createAt: String?
    var createBy: String?
    var description: String?
    var id: Int=0//音频专辑ID
    var isPermission: Bool=false // 是否已购买
    var isPublish: Int=0
    var isValid: Int=0
    var poster: String?
    var price: String?//价格
    var coinAmount: String?//钬柴币
    var priceId: String?//价格ID
    var publishAt: String?
    var sharecount: String?
    var title: String?
    var updateAt: String?
    var updateBy: String?
    var userId: Int = 0
    var tipTypeCode: Int = 0//0.免费的专辑，1.已购买的专辑，2.未购买的
    /** 更新数量 */
    var updCount: Int = 0
    /** 更新状态 */
    var updStatus: Int = 0
    /** 是否可赠送 */
    var canGift: Bool = false
    /** tag内容 */
    var tagContent: String?
    //是否显示排行按钮和广告弹框
    var isList: Bool = false
    var talkerDesc: String?//职位描述
    var talkerName: String?//昵称
}

//音频条目模型
struct audiodirectoryListModel: HandyJSON {
    var list:[audiodirectoryModel]?
    
}
struct audiodirectoryModel: HandyJSON {
    var albumId: Int = 0
    var title: String?
    var asc: Bool = false
    // 专辑音乐总数
    var rowNumber: Int = 0
    
    var id: Int = 0//音频条目id
    var audioId: Int = 0//专辑id
    
    var orders: String?
    var poster: String?
    var isFree: Bool = false
    var timeCost: String?
    var isPublish: Bool = false
    var publishAt: String?
    var isValid: Bool = false
    var playcount: String?
    var addr: String?
    var createAt: String?
    var finished: Int = 0//是否播放完成
    var playThis: Int = 0//当前播放的音频条目
    var timeGone: String?//上次播放的时间戳
}

//音频精品课程模型
struct audioSelectListModel: HandyJSON {
    var list: [audioSelectModel]?
    
}
struct audioSelectModel: HandyJSON {
    //身份ID
    var selectaudio_id: Int = 0
    //身份对应的音频课
    var items: [homeAudioModel]?
    //身份名称
    var name: String?
    
    var number: String?
    //身份封面
    var poster: String?
    //标题
    var title: String?
}
//直播列表模型
struct liveListModel: HandyJSON {
    /** 正在直播的 */
    var startedLive: [Any]?
    /** 即将开始的 */
    var willStartLive: [Any]?
    /** 即将开始的 */
    var hotReviewLive: [Any]?
    
    var latestLive: latestLiveModel?
}
struct latestLiveModel: HandyJSON {
    var list: [liveModel]?
    
}
struct liveModel: HandyJSON {
    var live_id: Int = 0
    var title: String?
    var poster: String?
    var speaker: String?
    var introduction: String?
    var is_list: Bool = false
    var avatar: String?
    var content: String?
    var business_id: Int = 0
    var start_time: String?
    var end_time: String?
    var pay_deadline_time: String?
    var channel_number: String?
    var hx_roomid: String?
    var msg_notify_time: String?
    var rats_images: [Any]?
    var is_free: Bool = false
    var playback_url: String?
    var playback_permission: Bool = false
    var status: Int = 0
    var is_private:Bool = false
    var price: String?
    var applepay_price_id: String?
    var living_status: Int = 0
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

