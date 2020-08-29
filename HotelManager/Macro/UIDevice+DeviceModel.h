//
//  UIDevice+DeviceModel.h
//  WKWebViewDemo
//
//  Created by defuya on 2018/10/19.
//  Copyright © 2018年 hcjj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const Device_iPhone4;
extern NSString *const Device_iPhone4S;
extern NSString *const Device_iPhone5;
extern NSString *const Device_iPhone5S;
extern NSString *const Device_iPhone5C;
extern NSString *const Device_iPhone6;
extern NSString *const Device_iPhone6plus;
extern NSString *const Device_iPhone6S;
extern NSString *const Device_iPhone6Splus;
extern NSString *const Device_iPhone7;
extern NSString *const Device_iPhone7plus;
extern NSString *const Device_iPhone8;
extern NSString *const Device_iPhone8plus;
extern NSString *const Device_iPhoneX;
extern NSString *const Device_iPhoneXS;
extern NSString *const Device_iPhoneXSM;


@interface UIDevice_DeviceModel : NSObject
+(NSString *) deviceModel;
@end

NS_ASSUME_NONNULL_END
