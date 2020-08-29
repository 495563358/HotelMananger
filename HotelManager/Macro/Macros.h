//
//  Macros.h
//  bychat
//
//  Created by 胡彬 on 2018/7/4.
//  Copyright © 2018年 defu. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

#define MainWindow      [UIApplication sharedApplication].keyWindow
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define Screen_bounds   [UIScreen mainScreen].bounds
#define Screen_center   [UIApplication sharedApplication].keyWindow.center

#define USERDEFAULT     [NSUserDefaults standardUserDefaults]

#define kIs_iphone      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX     ScreenWidth >=375.0f && ScreenHeight >=812.0f&& kIs_iphone
#define SystemColor     color(220, 59, 64, 1)
/*
 (n – 40) / (1 – 40 / 255) = result
 (n-40)*255/215
 n=实际色值
 result=最后得出的色值结果
 */
#define NavSystemColor  color(214, 22.5, 28.5, 1)


//(69, 175, 94, 1) 34.4 160 64
/*宽度比例*/
#define Percent                 (CGFloat)ScreenWidth/375

/*状态栏高度*/
#define kStatusBarHeight        (CGFloat)(kIs_iPhoneX?(44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight           44
/*状态栏和导航栏总高度*/
#define SafeAreaTopHeight       (CGFloat)(kIs_iPhoneX?(88.0):(64.0))

/*底部安全区域*/
#define SafeAreaBottomHeight    (CGFloat)(kIs_iPhoneX?(34.0):(0))
/*TabBar高度*/
#define kTabBarHeight           (CGFloat)(kIs_iPhoneX?(49.0 + 34.0):(49.0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight        (CGFloat)(kIs_iPhoneX?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight        (SafeAreaTopHeight + kTabBarHeight)

#define CHAT_LIST_VIEW_TOP_Y    (ScreenHeight >= 812.0 ? 44 : 56)

#define color(r,g,b,al)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]
#define ColorHex(hex)       [UIColor colorWithHexString:hex]

#define Color_system        [UIColor colorWithRed:69/255.0 green:167/255.0 blue:251/255.0 alpha:1.0]
#define Color_mygray        [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]
#define Color_LightGray     [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]
#define Color_myyellow              color(244,200,41,1)
#define Color_gameBackground        color(25, 74, 51, 1)
#define ssRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];
#define PFR9Font [UIFont fontWithName:PFR size:9];
#define PFR8Font [UIFont fontWithName:PFR size:8];

static NSString *COLLECTIMAGESEND = @"COLLECTIMAGESEND";

//用来标识是群聊界面消息处理 还是 客服界面消息处理
//static NSString *IS_CUSTOM_CHAT = @"IS_CUSTOM_CHAT";

#endif /* Macros_h */
