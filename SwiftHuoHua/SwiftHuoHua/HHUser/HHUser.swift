//
//  HHUser.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/19.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
import HandyJSON

let path=(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String).appendingFormat("user.data")
class HHUser: NSObject,NSCoding,HandyJSON {
    
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
    
    required override init() {
        super.init()
    }
    //解档
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.user_id=aDecoder.decodeObject(forKey: "user_id") as? String
        self.userName=aDecoder.decodeObject(forKey: "userName") as? String
        self.nickName=aDecoder.decodeObject(forKey: "nickName") as? String
        self.password=aDecoder.decodeObject(forKey: "password") as? String
        self.avatar=aDecoder.decodeObject(forKey: "avatar") as? String
        self.phonenumber=aDecoder.decodeObject(forKey: "phonenumber") as? String
        self.birthday=aDecoder.decodeObject(forKey: "birthday") as? String
        self.gender=aDecoder.decodeObject(forKey: "gender") as? String
        self.province=aDecoder.decodeObject(forKey: "province") as? String
        self.city=aDecoder.decodeObject(forKey: "city") as? String
        
        self.district=aDecoder.decodeObject(forKey: "district") as? String
        self.address=aDecoder.decodeObject(forKey: "address") as? String
        self.organization=aDecoder.decodeObject(forKey: "organization") as? String
        self.position_id=aDecoder.decodeInteger(forKey: "position_id")
        self.position_name=aDecoder.decodeObject(forKey: "position_name") as? String
        self.is_complete=aDecoder.decodeBool(forKey: "is_complete")
        self.token=aDecoder.decodeObject(forKey: "token") as? String
        self.user_email=aDecoder.decodeObject(forKey: "user_email") as? String
        self.is_concern=aDecoder.decodeBool(forKey: "is_concern")
        self.is_v=aDecoder.decodeInteger(forKey: "is_v")
        self.is_tourist=aDecoder.decodeInteger(forKey: "is_tourist")
        self.isVerification=aDecoder.decodeBool(forKey: "isVerification")
    }
    //归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.user_id, forKey: "user_id")
        aCoder.encode(self.nickName, forKey: "nickName")
        aCoder.encode(self.password, forKey: "password")
        aCoder.encode(self.avatar, forKey: "avatar")
        aCoder.encode(self.phonenumber, forKey: "phonenumber")
        aCoder.encode(self.birthday, forKey: "birthday")
        aCoder.encode(self.gender, forKey: "gender")
        aCoder.encode(self.province, forKey: "province")
        aCoder.encode(self.city, forKey: "city")
        aCoder.encode(self.district, forKey: "district")
        aCoder.encode(self.address, forKey: "address")
        aCoder.encode(self.organization, forKey: "organization")
        aCoder.encode(self.position_id, forKey: "position_id")
        aCoder.encode(self.position_name, forKey: "position_name")
        aCoder.encode(self.is_complete, forKey: "is_complete")
        aCoder.encode(self.token, forKey: "token")
        aCoder.encode(self.user_email, forKey: "user_email")
        aCoder.encode(self.is_concern, forKey: "is_concern")
        aCoder.encode(self.is_v, forKey: "is_v")
        aCoder.encode(self.is_tourist, forKey: "is_tourist")
        aCoder.encode(self.isVerification, forKey: "isVerification")
    }
    class func save(user:HHUser)->Bool{
        return NSKeyedArchiver.archiveRootObject(user, toFile: path)
    }
    
    class func user()->HHUser?{
        return  NSKeyedUnarchiver.unarchiveObject(withFile: path) as? HHUser
    }
}
