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
    fileprivate var currentRate: Float?//当前速率
    fileprivate var timeNumber: Float?//记录的时间戳
    fileprivate var is_recoreSucce: Bool = false//专辑播放是否记录成功
    fileprivate var cycle: HHAudioPlayCycle = .AudioPlayTheSong
    fileprivate var timeObserve: AnyObject?
//    @property (nonatomic,strong)CQProcessView *playbtn;//悬浮框播放按钮
//    @property (nonatomic,strong)SZAudioplyView *playView;//音频悬浮框
//    fileprivate (set) var managedObjectContext:
    //初始化

    static let sharedInstance = HHAudioPlayManger()
    
    private override init() {
        super.init()
        self.currentRate = 1.0
        self.selectrow = 1
        self.currentreteStr = "1x倍速"
        //支持后台播放
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback)
        }catch let err {
            print("设置类型失败：\(err.localizedDescription)")
        }
        
//        AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback) try
        // 开始监控
        UIApplication.shared.beginReceivingRemoteControlEvents()
        // 处理中断事件的通知
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterreption(noti:)), name: AVAudioSession.interruptionNotification, object: session)
        
        // 设置耳机插入拔出通知
        NotificationCenter.default.addObserver(self, selector: #selector(audioRouteChangeListenerCallback(notification:)), name: AVAudioSession.routeChangeNotification, object: nil)
    }
}
//通知方法
extension HHAudioPlayManger
{
     // 处理中断事件的通知
    @objc func handleInterreption(noti:Notification)  {
        
    }
    // 耳机通知处理方法
    @objc func audioRouteChangeListenerCallback(notification:Notification) {
//        let interuptionDict:[String:Any] = notification.userInfo as! [String : Any];
//        let routeChangeReason: UInt = UInt(interuptionDict[AVAudioSessionRouteChangeReasonKey])
////            [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
//        switch (routeChangeReason) {
//        case AVAudioSession.RouteChangeReason.newDeviceAvailable: break    // 耳机插入
//        
//        case AVAudioSession.RouteChangeReason.oldDeviceUnavailable:  // 耳机拔出，停止播放操作
//        
//        break;
//        case AVAudioSession.RouteChangeReason.categoryChange:            // called at start - also when other audio wants to play
//            
//            break;
//        }
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
        
        guard let url = tracks.addr?.fromBase64() else {
            return
        }
        //移除当前player的TimeObserver
        
        let musicURL = URL.changeUrlwithChinese(urlstr: url)
        self.currentPlayerItem = AVPlayerItem(url: musicURL)
        self.player = AVPlayer(playerItem: self.currentPlayerItem)
        isPlay=true
        play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playbackFinished(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: currentPlayerItem)
    }
    
    
    @objc fileprivate func playbackFinished(notification: Notification){
        if cycle == .AudioPlayTheSong  {
            //首页循环
        }
    }
    
    public func playInAlbumAudioWithModel(audioModel:audiodirectoryModel , indexPathRow: Int) {
        self.playWithModel(tracks: audioModel, indexPathRow: indexPathRow)
    }
    
    // 移除player 的TimeObserver
    fileprivate func removeMusicTimeMake(){
        if timeObserve != nil {
            player.removeTimeObserver(timeObserve as Any)
        }
    }
    
    //MARK:- 播放方法
    
    fileprivate func play()
    {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(true)
        }catch let err {
            print("设置类型失败：\(err.localizedDescription)")
        }
        
        if #available(iOS 10.0, *) {
            self.player.playImmediately(atRate: 1.0)
        } else {
            // Fallback on earlier versions
            self.player.play()
        }
    }
    
    //MARK:- 时间变化监听
    public func addMusicTimeMake(){
         timeObserve = self.player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(1.0), timescale: CMTimeScale(1.0)), queue: DispatchQueue.main) {[weak self] (time) in
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "musicTimeInterval")))
            let current = CMTimeGetSeconds(self?.player.currentItem?.currentTime() ?? CMTime())
            let endtime = CMTimeGetSeconds(self?.player.currentItem?.duration ?? CMTime())
            
            if current > 0 {
                
            }
            
            } as AnyObject
        
    }
    //接收动作
    public func pauseMusic() {
        if self.player.rate == 1.0 {
            self.isPlay = false
            //停止播放
            self.player.pause()
        } else {
            self.isPlay = true
            self.player.play()
        }
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
        if currentPlayerItem?.status == AVPlayerItem.Status.readyToPlay {
            return 1
        }
        else {
            return 0
        }
        
    }
    public func currentPlayIndex() -> Int {
        return indexPathRow ?? 0
    }
    public func getCurrentAlbumModel() -> homeAudioModel {
        return homeAudioModel()
    }
    public func havePlay() -> Bool{
        return isPlay
    }
    //调整速率方法
    public func setRateClick(selectrate:Float , row: Int) {
        self.selectrow = row
        self.currentRate = selectrate
        //在播放的时候就直接调整速率
        if self.isPlay {
            self.player.rate=selectrate
        }
    }
    
}


