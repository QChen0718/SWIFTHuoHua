//
//  NSDateExtension.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/28.
//  Copyright © 2019 White-C. All rights reserved.
//

import Foundation
extension NSDate{
    class func tiemnumberConversion(time: NSString, fromat: String) -> String {
        let timeStr = time.longLongValue
        let date = Date.init(timeIntervalSince1970: TimeInterval(timeStr))
        let formatter = DateFormatter.init()
        formatter.dateFormat.append(fromat)
        return formatter.string(from: date)
    }
}
