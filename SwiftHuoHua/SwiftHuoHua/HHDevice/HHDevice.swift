//
//  HHDevice.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/16.
//  Copyright © 2019 White-C. All rights reserved.
//

import Foundation
import UIKit
//屏幕宽度
let HHScreenWidth:CGFloat = UIScreen.main.bounds.width
//屏幕高度
let HHScreenHeight:CGFloat = UIScreen.main.bounds.height
//iPhoneX / iPhoneXS
let isIphoneX_XS = (HHScreenWidth == 375.0 && HHScreenHeight == 812.0 ? true : false)
//iPhoneXR / iPhoneXSMax
let isIphoneXR_XSMax = (HHScreenWidth == 414.0 && HHScreenHeight == 896.0 ? true : false)
//异性全面屏
let SZisFullScreen = (isIphoneX_XS || isIphoneXR_XSMax)
// 状态栏高度
let STATUS_BAR_HEIGHT:CGFloat = (SZisFullScreen ? 44.0 : 20.0)
//
let STATUS_HEIGHT_CHA:CGFloat = (SZisFullScreen ? 24.0 : 0.0)
// 导航栏高度
let NAVIGATION_BAR_HEIGHT:CGFloat = (SZisFullScreen ? 88.0 : 64.0)
// tabBar高度
let TAB_BAR_HEIGHT:CGFloat = (SZisFullScreen ? (49.0+34.0) : 49.0)
// home indicator
let HOME_INDICATOR_HEIGHT:CGFloat = (SZisFullScreen ? 34.0 : 0.0)
// 底部按钮
let BOTTOM_HEIGHT:CGFloat = (SZisFullScreen ? 34.0 : 20.0)
// 屏幕比例
let KScreenRate = (375.0 / HHScreenWidth)

func KSuitFloat(float:CGFloat) -> CGFloat
{
    return (float / KScreenRate)
}

func KSuitSize(width:CGFloat, height:CGFloat) -> CGSize
{
   return CGSize(width: width / KScreenRate, height: height / KScreenRate)
}

func KSuitPoint(x:CGFloat, y:CGFloat) -> CGPoint
{
    return CGPoint(x: x / KScreenRate, y: y / KScreenRate)
}

func KSuitFrame(x:CGFloat, y:CGFloat, width:CGFloat, heigth:CGFloat) -> CGRect
{
   return CGRect(x: x / KScreenRate, y: y / KScreenRate, width: width / KScreenRate, height: heigth / KScreenRate)
}



