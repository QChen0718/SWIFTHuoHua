//
//  NSStringExtension.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/29.
//  Copyright © 2019 White-C. All rights reserved.
//

import Foundation

extension String {
    // base64编码
    func toBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    // base64解码
    func fromBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

