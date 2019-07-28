//
//  HomeAudioCollectionCell.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/21.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HomeAudioCollectionCell: UICollectionViewCell {

    //音频封面
    @IBOutlet weak var audiocorver: UIImageView!
    //音频播放数
    @IBOutlet weak var playcout: UILabel!
    //音频标题
    @IBOutlet weak var audiotitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.audiocorver.layer.cornerRadius=5
        self.audiocorver.clipsToBounds=true
    }
    public func setModel(model:homeAudioModel)
    {
        self.audiocorver.kf.setImage(urlString: model.poster)
        self.playcout.text="\(model.count ?? "")人已学习"
        self.audiotitle.text=model.title
    }
}
