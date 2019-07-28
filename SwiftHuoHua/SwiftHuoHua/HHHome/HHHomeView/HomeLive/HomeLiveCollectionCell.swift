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
        
//        livestatus.text =
        livedate.text = model.start_time ?? ""
    }
}
