//
//  HHRefresh.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/21.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView{
    var HHHead: MJRefreshHeader {
        get { return mj_header}
        set { mj_header = newValue}
    }
    
    var HHFoot: MJRefreshFooter {
        get { return mj_footer}
        set { mj_footer = newValue}
    }
}

class HHRefreshHeader: MJRefreshGifHeader {
    //重写初始化方法
    override func prepare() {
        super.prepare()
        /** 普通闲置状态 */
        setImages([UIImage(named: "loading_20")!], for: .idle)
        /** 松开就可以进行刷新的状态 */
        setImages([UIImage(named: "loading_1")!], for: .pulling)
        //定义一个可变数组，并初始化
        var images:[UIImage]? = [UIImage]()
        for index in 1...20
        {
            images?.append(UIImage(named: "loading_\(index)")!)
        }
        setImages(images, for: .refreshing)
        //不显示上次的刷新时间
        lastUpdatedTimeLabel.isHidden = true
        //不显示刷新状态的label
        stateLabel.isHidden = true
    }
}

class HHRefreshAutoHeader: MJRefreshHeader {
    
}

class HHRefreshFooter: MJRefreshBackNormalFooter {}

class HHRefreshAutoFooter: MJRefreshAutoFooter {}
//自定义尾部加载动画
class HHRefreshAutoGifFooter: MJRefreshAutoGifFooter {
    override func prepare() {
        super.prepare()
        
    }
}
//无数据显示
class HHRefreshDiscoverFooter: MJRefreshBackGifFooter {
    override func prepare() {
        super.prepare()
        backgroundColor = UIColor.white
        setImages([UIImage(named: "no_more_data")!], for: .noMoreData)
        stateLabel.isHidden = true
        refreshingBlock = { self.endRefreshing() }
    }
}

class HHRefreshTipKissFooter: MJRefreshBackFooter {
    lazy var tipLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.textColor = UIColor.lightGray
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.numberOfLines = 0
        return tl
    }()
    
    lazy var imageView: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage(named: "blank_noNetwork")
       return iw
    }()
    
    override func prepare() {
        super .prepare()
        backgroundColor = UIColor.white
        mj_h = 240
        addSubview(tipLabel)
        addSubview(imageView)
    }
    
    override func placeSubviews() {
        tipLabel.frame = CGRect(x: 0, y: 40, width: bounds.width, height: 60)
        imageView.frame = CGRect(x: (bounds.width - 80)/2, y: 110, width: 80, height: 80)
    }
    
    convenience init(with tip: String) {
        self.init()
        refreshingBlock = {self.endRefreshing()}
        tipLabel.text = tip
    }
}
