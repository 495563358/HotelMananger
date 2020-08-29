//
//  ObjectTools.m
//  SmartHome
//
//  Created by Smart house on 2018/2/1.
//  Copyright © 2018年 Verb. All rights reserved.
//

#import "ObjectTools.h"

#import <CommonCrypto/CommonDigest.h>

//Push

@implementation ObjectTools

static AFHTTPSessionManager *afnManager = nil;

+(AFHTTPSessionManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        afnManager = [AFHTTPSessionManager manager];
        afnManager.requestSerializer.timeoutInterval = 5.0;
        afnManager.requestSerializer = [AFJSONRequestSerializer serializer];
        afnManager.responseSerializer = [AFJSONResponseSerializer serializer];
        afnManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html",@"text/plain",@"image/png", nil];
        
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString *token = [user objectForKey:@"token"];
//        if (token) {
//            [afnManager.requestSerializer setValue:[@"1" stringByAppendingString:token] forHTTPHeaderField:@"FROMWAY"];
//        }else{
//            [afnManager.requestSerializer setValue:@"1" forHTTPHeaderField:@"FROMWAY"];
//        }
        
    });
    return afnManager;
}

//加载网页端数据 移除网页端导航栏
+(void)removeHead{
    NSString *userAgent = [[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSLog(@"userAgent :%@", userAgent);
    
    NSString *newAgent = userAgent;
    if (![userAgent hasSuffix:@"/znhome/2.0.6"])
    {
        newAgent = [userAgent stringByAppendingString:@"/znhome/2.0.6"];
    }
    NSDictionary *newdict = @{@"UserAgent":newAgent};
    [[NSUserDefaults standardUserDefaults] registerDefaults:newdict];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (UIViewController *)visibleViewController {
    UIViewController *rootViewController =[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    return [ObjectTools getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [ObjectTools getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [ObjectTools getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [ObjectTools getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
    
}

+(NSString *)GetNonce{
    NSArray *arr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    
    NSMutableString *mStr = [[NSMutableString alloc]init];
    for (int i = 0; i < 16; i++) {
        int x = arc4random()%36;
        [mStr appendString:arr[x]];
    }
    return mStr;
}

//MD5小写加密
+ (NSString*)md532BitLower:(NSString *)md5Str
{
    const char *cStr = [md5Str UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

@end
