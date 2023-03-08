//
//  UIConst.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import UIKit

public let OnePixel = 1 / UIScreen.main.scale
public var ScreenWidth = UIScreen.main.bounds.width
public let ScreenHeight = UIScreen.main.bounds.height

public let Is4InchScreen = (ScreenHeight == 568)
public let IsLargeThan4Inch = (ScreenHeight > 320)
public let IsLargeThan6Screen = (ScreenHeight > 375)
public let IsLargeThan6PScreen = (ScreenWidth > 414)
public let IsSmallThan5Screen = (ScreenHeight <= 568)

public let Is3_5InchScreen = (ScreenHeight == 480)
public let Is4_0InchScreen = (ScreenHeight == 568)
public let Is4_7InchScreen = (ScreenHeight == 667)
public let Is5_5InchScreen = (ScreenHeight == 736)
public let Is5_8InchScreen = (ScreenHeight == 812 && ScreenWidth == 375)
public let Is6_1InchScreen = ((ScreenHeight == 896 && ScreenWidth == 414) || (ScreenHeight == 844 && ScreenWidth == 390))
public let Is6_5InchScreen = (ScreenHeight == 896 && ScreenWidth == 414)
public let Is5_4InchScreen = (ScreenHeight == 812 && ScreenWidth == 375)
public let Is6_7InchScreen = (ScreenHeight == 926 && ScreenWidth == 428)

public let IsIphoneX = (Is5_8InchScreen || Is6_1InchScreen || Is6_5InchScreen || Is5_4InchScreen || Is6_7InchScreen)
public let LowerOrEqualThanIphone5S = (ScreenWidth <= 320)
public let IsTallThan3_5InchScreen = (ScreenHeight > 480)
public let AdjustRatioAccrodingToScreenWidth = (ScreenWidth / 320)
public let IsLargerThan_375_Screen = (ScreenWidth > 375)

public let StatusBarHeight = UIApplication.shared.isStatusBarHidden ? (IsIphoneX ? 44 : 20) : UIApplication.shared.statusBarFrame.size.height

public let StatusBarAndNaviBarHeight = (StatusBarHeight + 44)
public let TabBarHeight = (IsIphoneX ? IphoneXTabbarHeight : 49)
public let IphoneXTabbarAdditionalHeight = 34
public let IphoneXTabbarHeight = (IphoneXTabbarAdditionalHeight + 49)
