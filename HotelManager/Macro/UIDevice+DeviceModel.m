//
//  UIDevice+DeviceModel.m
//  WKWebViewDemo
//
//  Created by defuya on 2018/10/19.
//  Copyright © 2018年 hcjj. All rights reserved.
//

#import "UIDevice+DeviceModel.h"
#import <sys/utsname.h>
NSString *const Device_iPhone4 = @"iPhone 4";
NSString *const Device_iPhone4S = @"iPhone 4S";
NSString *const Device_iPhone5 = @"iPhone 5";
NSString *const Device_iPhone5S = @"iPhone 5S";
NSString *const Device_iPhone5C = @"iPhone 5C";

NSString *const Device_iPhone6 = @"iPhone 6";
NSString *const Device_iPhone6plus = @"iPhone 6 Plus";
NSString *const Device_iPhone6S = @"iPhone 6S";
NSString *const Device_iPhone6Splus = @"iPhone 6S Plus";
NSString *const Device_iPhone7 = @"iPhone 7";
NSString *const Device_iPhone7plus = @"iPhone 7 Plus";
NSString *const Device_iPhone8 = @"iPhone 8";
NSString *const Device_iPhone8plus = @"iPhone 8 Plus";
NSString *const Device_iPhoneX = @"iPhone X";
NSString *const Device_iPhoneXS = @"iPhone XS";
NSString *const Device_iPhoneXSM = @"iPhone XSM";
NSString *const Device_iPhoneXR = @"iPhone XR";
@implementation UIDevice_DeviceModel

+ (NSString *)deviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSLog(@"======================%@",code);
    static NSDictionary* deviceNamesByCode = nil;
    if (!deviceNamesByCode) {
        deviceNamesByCode = @{
                              
                              @"iPhone3,1" : Device_iPhone4,
                              @"iPhone3,2" : Device_iPhone4,
                              @"iPhone3,3" : Device_iPhone4,
                              @"iPhone4,1" : Device_iPhone4S,
                              @"iPhone5,1" : Device_iPhone5,
                              @"iPhone5,2" : Device_iPhone5,
                              @"iPhone5,3" : Device_iPhone5C,
                              @"iPhone5,4" : Device_iPhone5C,
                              @"iPhone6,1" : Device_iPhone5S,
                              @"iPhone6,2" : Device_iPhone5S,
                              @"iPhone7,1" : Device_iPhone6plus,
                              @"iPhone7,2" : Device_iPhone6,
                              @"iPhone8,1" : Device_iPhone6S,
                              @"iPhone8,2" : Device_iPhone6Splus,
                              @"iPhone9,1" : Device_iPhone7,
                              @"iPhone9,2" : Device_iPhone7plus,
                              @"iPhone10,1" : Device_iPhone8,
                              @"iPhone10,2" : Device_iPhone8plus,
                              @"iPhone10,3" : Device_iPhoneX,
                              @"iPhone11,2" : Device_iPhoneXS,
                              @"iPhone11,6" : Device_iPhoneXSM,
                              @"iPhone11,1" : Device_iPhoneXR
                              
                              };
        
    }
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    if(deviceName){
        
       
        
    }
 
     return deviceName;
}






@end
