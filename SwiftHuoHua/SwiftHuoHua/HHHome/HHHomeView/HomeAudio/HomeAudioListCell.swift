//
//  HomeAudioListCell.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/24.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HomeAudioListCell: UITableViewCell {

    @IBOutlet weak var audiocorver: UIImageView!
    @IBOutlet weak var audiotitle: UILabel!
    @IBOutlet weak var audiodsc: UILabel!
    @IBOutlet weak var audiosubtitle: UILabel!
    @IBOutlet weak var audiobuystatus: UILabel!
    @IBOutlet weak var playnumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.audiocorver.layer.cornerRadius=5
        self.audiocorver.clipsToBounds=true
    }

    
    public func setDataModel(model:homeAudioModel)
    {
        audiocorver.kf.setImage(urlString: model.poster)
        audiotitle.text=model.title
        audiodsc.text=model.description
        audiosubtitle.text=model.talkerDesc
        audiobuystatus.text="免费"
        playnumber.text = "\(model.count ?? "0")人已收听"
    }
}
