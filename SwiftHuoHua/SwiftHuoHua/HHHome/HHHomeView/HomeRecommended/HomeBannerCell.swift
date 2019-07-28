//
//  HomeBannerCell.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/21.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
import LLCycleScrollView

class HomeBannerCell: UITableViewCell {

    //懒加载banner
    private lazy var bannerView: LLCycleScrollView = {
        let banner = LLCycleScrollView()
        //        滚动间隔时间
        banner.autoScrollTimeInterval = 6
        //默认占位图
        banner.placeHolderImage = UIImage(named: "hh_img_defaultPhoto")
        banner.coverImage = UIImage()
        banner.pageControlPosition = .right
        banner.pageControlBottom = 20
        banner.titleBackgroundColor = UIColor.clear
        //        banner.lldidSelectItemAtIndex = didsele
        return banner
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 添加banner
        self.contentView.addSubview(bannerView)
        //设置banner的大小
        bannerView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
            $0.height.equalTo(KSuitFloat(float: 120))
        }
    }
    public func setDataClick(urlstr:String)
    {
        bannerView.imagePaths=[urlstr,"http://omxx7cyms.bkt.clouddn.com/o_1detrosj41bo2p58jmkb33m707.jpeg"]
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
