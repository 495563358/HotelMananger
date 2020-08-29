//
//  ObjectTools.h
//  SmartHome
//
//  Created by Smart house on 2018/2/1.
//  Copyright © 2018年 Verb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"


@interface ObjectTools : NSObject

//加载网页端数据 移除网页端导航栏
+(void)removeHead;

+(AFHTTPSessionManager *)sharedManager;

+(UIViewController *)visibleViewController;

+(NSString *)GetNonce;

+(NSString*)md532BitLower:(NSString *)md5Str;
@end
