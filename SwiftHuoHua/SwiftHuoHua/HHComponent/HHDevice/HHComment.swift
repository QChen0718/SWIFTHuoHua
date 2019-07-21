//
//  HHComment.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/21.
//  Copyright © 2019 White-C. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


//MARK:- Kingfisher
//对 Kingfisher 进行扩展 只针对 ImageView
extension Kingfisher where Base: ImageView {
    @discardableResult
    //写一个公开的获取网络图片的方法
    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "hh_img_defaultPhoto")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""), placeholder: placeholder, options: [.transition(.fade(0.5))])
    }
}

extension Kingfisher where Base: UIButton {
    @discardableResult
    public func setImage(urlString: String?, for state: UIControl.State, placeholder: UIImage? = UIImage(named: "hh_img_defaultPhoto")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""), for: state, placeholder: placeholder, options: [.transition(.fade(0.5))])
    }
}
