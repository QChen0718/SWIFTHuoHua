//
//  AudiolistCell.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/24.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class AudiolistCell: UITableViewCell {

    @IBOutlet weak var pauseaudio: UIImageView!
    @IBOutlet weak var playaudio: UIImageView!
    @IBOutlet weak var audiotitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         var nameArray = [UIImage]()
        for index in 1...8 {
            
            nameArray.append(UIImage(named:"audio_list_icn_loading\(index)")!)
        }
//        self.pauseaudio.
        self.pauseaudio.animationImages = nameArray
        self.pauseaudio.animationDuration = 0.5
    }

    public var indexpath: IndexPath?
    public var selectrow: Int = -1
    
    public func setdataModel(model:audiodirectoryModel)
    {
        audiotitle.text=model.title ?? ""
        if indexpath?.row == self.selectrow || model.playThis==1 {
            self.playaudio.isHidden=true
            self.pauseaudio.isHidden = false
            if HHAudioPlayManger.sharedInstance.havePlay()
            {
                self.pauseaudio.startAnimating()
            }else {
                self.pauseaudio.stopAnimating()
            }
            audiotitle.textColor=UIColor.hexadecimalColor(hexadecimal: "0xFFD000")
        }
        else
        {
            
            self.playaudio.isHidden=false
            self.pauseaudio.isHidden = true
            self.pauseaudio.stopAnimating()
            if model.finished == 1
            {
                //表示该条目音频播放完成
                audiotitle.textColor=UIColor.hexadecimalColor(hexadecimal: "0x9B9B9B")
            }else{
                //默认没有开始播放的
                audiotitle.textColor=UIColor.hexadecimalColor(hexadecimal: "0x262626")
            }
        }
    }
    
}
