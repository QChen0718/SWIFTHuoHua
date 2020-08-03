//
//  CircleContentView.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2020/8/3.
//  Copyright © 2020 White-C. All rights reserved.
//

import UIKit

class CircleContentView: UIView {
    fileprivate lazy var photosView:UIImageView={
        let imageview = UIImageView(frame: .zero)
        imageview.backgroundColor = .red
        return imageview
    }()
    public var photosArray:[String]?
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        setFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CircleContentView{
    fileprivate func createUI(){
        addSubview(photosView)
        
    }
    fileprivate func setFrame(){
        photosView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}
