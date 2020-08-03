//
//  HomeLiveCollectionCell.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/26.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HomeLiveCollectionCell: UICollectionViewCell {

    @IBOutlet weak var livecorver: UIImageView!
    @IBOutlet weak var livetitle: UILabel!
    @IBOutlet weak var livestatus: UILabel!
    @IBOutlet weak var livedate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setDataModel(model:liveModel)
    {
        livecorver.kf.setImage(urlString: model.poster ?? "")
        livetitle.text = model.title ?? ""
        if (model.playback_url?.count ?? 0 > 0) {
            livestatus.text = "可回看"
            livestatus.textColor = UIColor.hexadecimalColor(hexadecimal: "0x51B9BC")
        } else {
            //直播状态
            /* 1:  正在直播
             2： 直播已结束
             3： 直播未开始  */
            if model.living_status == 1 {
                livestatus.text = "直播中"
                livestatus.textColor = UIColor.hexadecimalColor(hexadecimal: "0xF05522")
            }
            else if model.living_status == 2 {
                livestatus.text = "已结束"
                livestatus.textColor = UIColor.hexadecimalColor(hexadecimal: "0xC4C4C4")
            }
            else if model.living_status == 3 {
                livestatus.text = "即将开始"
                livestatus.textColor = UIColor.hexadecimalColor(hexadecimal: "0xFFBA00")
            }
        }
//        livestatus.text =
        livedate.text = NSDate.tiemnumberConversion(time: (model.start_time ?? "") as NSString, fromat: "yy-MM-dd")
    }
}
