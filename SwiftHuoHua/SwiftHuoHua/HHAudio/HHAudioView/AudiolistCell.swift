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
    }

    public func setdataModel(model:audiodirectoryModel)
    {
        audiotitle.text=model.title ?? ""
    }
    
}
