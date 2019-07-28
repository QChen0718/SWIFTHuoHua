//
//  HHHomeTableViewCell.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/21.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var dsclabel: UILabel!
    
    @IBOutlet weak var corverImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.corverImage.layer.cornerRadius = 5
        self.corverImage.clipsToBounds=true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
