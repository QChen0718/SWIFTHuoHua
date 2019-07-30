//
//  NSUrlExtension.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/29.
//  Copyright © 2019 White-C. All rights reserved.
//

import Foundation
extension URL {
    static func changeUrlwithChinese(urlstr: String? = "") -> URL {
        let  UTF8urlStr = urlstr?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        return URL(string: UTF8urlStr)!
    }
}
