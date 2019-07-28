//
//  HHAudioIntroduceViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/23.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHAudioIntroduceViewController: HHBaseViewController {

    var audiodetail_id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
      let vc = HHWebViewController(url: "\(kH5CommentUrl)/app/album/detail/\(self.audiodetail_id ?? 0)?token=\(HHUser.user()?.token ?? "")")
//
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
