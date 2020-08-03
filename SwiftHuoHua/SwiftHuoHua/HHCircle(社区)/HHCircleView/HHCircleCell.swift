//
//  HHCircleCell.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2020/8/3.
//  Copyright © 2020 White-C. All rights reserved.
//

import UIKit

class HHCircleCell: UITableViewCell {
    fileprivate lazy var headerimage:UIImageView={
        let imageview = UIImageView(frame: .zero)
        imageview.backgroundColor = .red
        return imageview
    }()
    fileprivate lazy var titleLabel:UILabel={
        let label = UILabel(frame: .zero)
        label.text = "教育品牌设计大咖"
        return label
    }()
    fileprivate lazy var datelabel:UILabel={
        let label = UILabel(frame: .zero)
        label.text = "07-02 23:54"
        return label
    }()
    fileprivate lazy var contentlabel:UILabel={
        let label = UILabel(frame: .zero)
        label.text = "校区设计，最棒的效果，最专业的软装，最低的装修成本，95%的效果还原度。客户100%的满意。校区设计，最棒的效果，最专业的软装，最低的装修成本，95%的效果还原度。客户100%的满意。校区设计，最棒的效果，最专业的软装，最低的装修成本，95%的效果还原度。客户100%的满意。"
        label.numberOfLines=5
        return label
    }()
    fileprivate lazy var contentview:CircleContentView={
        let view = CircleContentView(frame: .zero)
        return view
    }()
    fileprivate lazy var bottomview:CircleBottomView={
        let view = CircleBottomView(frame: .zero)
        view.backgroundColor = .blue
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
        setFrame()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension HHCircleCell{
    fileprivate func createUI(){
        contentView.addSubview(headerimage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(datelabel)
        contentView.addSubview(contentlabel)
        contentView.addSubview(contentview)
        contentView.addSubview(bottomview)
    }
    fileprivate func setFrame(){
        headerimage.snp.makeConstraints { (make) in
            make.left.top.equalTo(KSuitFloat(float: 15))
            make.size.equalTo(KSuitSize(width: 42, height: 42))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerimage.snp_right).offset(KSuitFloat(float: 15))
            make.right.equalTo(KSuitFloat(float: -15))
            make.height.equalTo(KSuitFloat(float: 20))
            make.top.equalTo(headerimage)
        }
        datelabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(KSuitFloat(float: 15))
            make.top.equalTo(titleLabel.snp_bottom).offset(KSuitFloat(float: 5))
        }
        contentlabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerimage)
            make.top.equalTo(headerimage.snp_bottom).offset(KSuitFloat(float: 15))
            make.right.equalTo(KSuitFloat(float: -15))
        }
        contentview.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentlabel)
            make.top.equalTo(contentlabel.snp_bottom).offset(KSuitFloat(float: 15))
            make.height.equalTo(KSuitFloat(float: 200))
        }
        bottomview.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentlabel)
            make.top.equalTo(contentview.snp_bottom).offset(KSuitFloat(float: 20))
            make.height.equalTo(KSuitFloat(float: 25))
            make.bottom.equalTo(KSuitFloat(float: -10))
        }
    }
    public func setdataDict(data:[String:[String]]){
        if let count = data["photos"]?.count,count>0 {
            contentview.isHidden = false
            var height = 0
            switch count {
            case 1:
                height = 120
                break
            case 2,3:
                height = 100
                break
            default:
                height = 200
                break
            }
            contentview.snp.updateConstraints { (make) in
                make.height.equalTo(KSuitFloat(float: CGFloat(height)))
            }
        }else{
            contentview.isHidden = true
//            先移除约束
            bottomview.snp.removeConstraints()
//            重新设置约束
            bottomview.snp.makeConstraints { (make) in
                make.top.equalTo(contentlabel.snp_bottom).offset(KSuitFloat(float: 15))
                make.left.right.equalTo(contentlabel)
                make.height.equalTo(KSuitFloat(float: 25))
                make.bottom.equalTo(KSuitFloat(float: -10))
            }
        }
    }
}
