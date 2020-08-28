//
//  ContributeCell.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2020/8/3.
//  Copyright © 2020 White-C. All rights reserved.
//

import UIKit

class ContributeCell: UITableViewCell {
    fileprivate lazy var titlelabel:UILabel={
        let label = UILabel(frame: .zero)
        return label
    }()
    fileprivate lazy var itemlabel:UILabel={
        let label = UILabel(frame: .zero)
        return label
    }()
    fileprivate lazy var datelabel:UILabel={
        let label = UILabel(frame: .zero)
        return label
    }()
    fileprivate lazy var photoimgeview:UIImageView={
        let imageview = UIImageView(frame: .zero)
        return imageview
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
        setFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ContributeCell{
    fileprivate func createUI(){
        addSubview(titlelabel)
        addSubview(itemlabel)
        addSubview(datelabel)
        addSubview(photoimgeview)
    }
    fileprivate func setFrame(){
        photoimgeview.snp.makeConstraints { (make) in
            make.right.equalTo(KSuitFloat(float: -15))
            make.size.equalTo(KSuitSize(width: 50, height: 50))
            make.top.equalTo(KSuitFloat(float: 5))
        }
        titlelabel.snp.makeConstraints { (make) in
            make.left.equalTo(KSuitFloat(float: 15))
//            make.right.equalTo()
        }
        itemlabel.snp.makeConstraints { (make) in
            make.left.equalTo(KSuitFloat(float: 15))
//            make.
        }
    }
}
