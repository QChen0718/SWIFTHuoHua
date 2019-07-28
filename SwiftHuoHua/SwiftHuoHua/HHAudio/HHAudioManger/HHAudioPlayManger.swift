//
//  HHAudioPlayManger.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/25.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

// 音频系统库
import AVFoundation
// 播放模式
enum HHAudioPlayCycle: Int {
    case AudioPlayTheSong = 1      //首页循环
    case AudioPlayNextSong         //循环播放
    case AudioPlayIsRandom         //随机播放
}
// 播放状态
enum itemModel: Int {
    case historyItem = 0
    case favoritelItem
}
class HHAudioPlayManger: NSObject {
    var player = AVPlayer()
    var isPlay: Bool = false //是否播放
    var timeGone: String? //记录的时间戳
    var currentreteStr: String? //当前选中的速率
    var selectrow: Int = -1
    
    fileprivate var currentPlayerItem: AVPlayerItem? //当前播放的音频
    fileprivate var favoriteMusic = [AnyObject]() //历史播放
    fileprivate var historyMusic = [AnyObject]()    // 喜爱 收藏
    fileprivate var isLocalVideo: Bool = false //是否播放本地文件
    fileprivate var isFinishLoad: Bool = false //是否下载完毕
    fileprivate var soundIDs = [String:Any]() //音效
    fileprivate var tracksM:audiodirectoryModel?
    fileprivate var indexPathRow: Int? //当前播放行
    fileprivate var rowNumber: Int?
    fileprivate var albumAudioArr = [AnyObject]() //专辑音频数组
//    fileprivate (set) var managedObjectContext: 
    //初始化
    class func sharedInstance() {
        
    }
    
}
extension HHAudioPlayManger
{
    //清空属性
    public func releasePlayer() {
        
    }
    /** 播放装载专辑 */
    //这个方法带入指定播放的时间戳
    public func playWithModel(tracks:audiodirectoryModel , indexPathRow:Int, albumModel:homeAudioModel? = nil, albumAudios:[homeAudioModel]? = []) {
        
    }
    
    public func playInAlbumAudioWithModel(audioModel:audiodirectoryModel , indexPathRow: Int) {
        
    }
    //接收动作
    public func pauseMusic() {
        
    }
    //播放模式
    public func previousMusic() {
        
    }
    //下一首歌曲
    public func nextMusic() {
        
    }
    public func nextCycle() {
        
    }
    /** 设置专辑内播放列表(在刷新列表数据时  后台数据肯能发生改变) */
    public func setAlbumAudiosArr(albumAudios: [AnyObject]){
        
    }
    //购买当前播放专辑
    public func payCurrentAlbumWithAlbum(albumModel:homeAudioModel){
        
    }
    //播放状态
    public func playerStatus() -> Int {
        return 0
    }
    public func currentPlayIndex() -> Int {
        return 0
    }
    public func getCurrentAlbumModel() -> homeAudioModel {
        return homeAudioModel()
    }
    public func havePlay() -> Bool{
        return false
    }
    //调整速率方法
    public func setRateClick(selectrate:CGFloat , row: Int) {
        
    }
}


