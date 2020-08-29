//
//  BaseocHttpService.m
//  SmartHome
//
//  Created by Smart house on 2018/4/4.
//  Copyright © 2018年 Verb. All rights reserved.
//

#import "BaseocHttpService.h"
#import "ObjectTools.h"
#import <CommonCrypto/CommonDigest.h>
#import "MBProgressHUD.h"
//#import <SVProgressHUD/SVProgressHUD.h>

@implementation BaseocHttpService


/*
 GET 返回所有情况
    rightBackBlock
    errorBackBlock
    failureBackBlock
 */
+(void)getRequest:(NSString *)urlStr andParagram:(id)paragram rightBlock:(rightBackBlock)right errorBlock:(errorBackBlock)error failur:(failureBackBlock)failure{
    
    UIView *visibleView = [ObjectTools visibleViewController].view;
    [MBProgressHUD showHUDAddedTo:visibleView animated:YES];
    
    [[ObjectTools sharedManager] GET:urlStr parameters:paragram progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideHUDForView:visibleView animated:YES];
        // NSLog(@"本次请求网址 = %@",urlStr);
        // NSLog(@"本次请求参数 = %@",paragram);
        // NSLog(@"本次请求结果 = %@",responseObject);
        
        NSDictionary *resp = (NSDictionary *)responseObject;
        if ([resp[@"code"] intValue] == 200) {
            id data = resp[@"data"];
            right(data);
        }else{
            error(responseObject);
            [DCSpeedy showToastWithText:resp[@"msg"]];
            [self backToHome:responseObject];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        {
            [MBProgressHUD hideHUDForView:visibleView animated:YES];
            [SVProgressHUD showErrorWithStatus:@"网络状态不好哦"];
            [SVProgressHUD dismissWithDelay:1.0];
            failure(error);
        }
    }];
    return;
}

/*
    GET 返回网络正常的情况 正确代码和错误代码
    rightBackBlock
    errorBackBlock
 */
+(void)getRequest:(NSString *)urlStr andParagram:(id)paragram rightBlock:(rightBackBlock)right errorBlock:(errorBackBlock)error{
    [[ObjectTools sharedManager] GET:urlStr parameters:paragram progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:NSDictionary.class]) {
            NSLog(@"返回类型异常");
            return;
        }
        NSDictionary *resp = (NSDictionary *)responseObject;
        if ([resp[@"code"] intValue] == 200) {
            id data = resp[@"data"];
            right(data);
        }else{
            error(responseObject);
            [self backToHome:responseObject];
            return;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    return;
}

/*
 GET 只返回正确代码 code = 200
 rightBackBlock
 */
+(void)getRequestWithoutError:(NSString *)urlStr andParagram:(id)paragram success:(void (^)(id responseObject))success{
    
    [[ObjectTools sharedManager] GET:urlStr parameters:paragram progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resp = (NSDictionary *)responseObject;
        if ([resp[@"code"] intValue] == 200) {
            success(resp[@"data"]);
        }else{
            if (resp[@"msg"]) {
//                [DCSpeedy showToastWithText:resp[@"msg"]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        {
            
        }
    }];
    return;
}


/*
 POST 返回正确结果 错误结果 网络失败不返回 直接在这里提示
 */
+(void)postRequest:(NSString *)urlStr andParagram:(id)paragram rightBlock:(rightBackBlock)right errorBlock:(errorBackBlock)error{
    
//    UIView *visibleView = [ObjectTools visibleViewController].view;
//    [MBProgressHUD showHUDAddedTo:visibleView animated:YES];
    
    
    UserModel *model = [(AppDelegate *)[UIApplication sharedApplication].delegate userModel];
    NSString *ownerId = model.ID;
    NSString *token = model.token;
    
    NSMutableDictionary *newParagram = [NSMutableDictionary dictionaryWithDictionary:paragram];
    [newParagram setValue:ownerId forKey:@"ownerId"];
    [newParagram setValue:token forKey:@"token"];
    
    [[ObjectTools sharedManager] POST:urlStr parameters:newParagram progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [MBProgressHUD hideHUDForView:visibleView animated:YES];
      NSLog(@"本次请求网址 = %@",urlStr);
      NSLog(@"本次请求参数 = %@",paragram);
      NSLog(@"本次请求结果 = %@",responseObject);
        if (![responseObject isKindOfClass:NSDictionary.class]) {
            NSLog(@"返回类型异常");
            return;
        }
        NSDictionary *resp = (NSDictionary *)responseObject;
        if ([resp[@"resultCode"] intValue] == 0) {
            id data = resp[@"resultData"];
            right(data);
        }else{
            error(responseObject);
            if(![[ObjectTools visibleViewController].className isEqualToString:@"LoadViewController"]){
                
                [SVProgressHUD showWithStatus:@"登录过期,请重新登录"];
                [SVProgressHUD dismissWithDelay:1.5];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"EXITSUCCESS" object:nil];
            }
//            [self backToHome:responseObject];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        {
            NSLog(@"%@",error);
//            [MBProgressHUD hideHUDForView:visibleView animated:YES];
            [SVProgressHUD showErrorWithStatus:@"网络状态不好哦"];
            [SVProgressHUD dismissWithDelay:1.0];
        }
    }];
    return;
}

/*
 只返回code == 200结果
 */
+(void)postRequestWithoutError:(NSString *)urlStr andParagram:(id)paragram success:(void (^)(id responseObject))success{
    
    [[ObjectTools sharedManager] POST:urlStr parameters:paragram progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //  NSLog(@"本次请求网址 = %@",urlStr);
       // NSLog(@"本次请求参数 = %@",paragram);
       // NSLog(@"本次请求结果 = %@",responseObject);
        
        if (![responseObject isKindOfClass:NSDictionary.class]) {
            NSLog(@"返回类型异常");
            return;
        }
        NSDictionary *resp = (NSDictionary *)responseObject;
        if ([resp[@"code"] intValue] != 200) {
            if (resp[@"msg"]) {
                NSLog(@"%@",resp[@"msg"]);
                [DCSpeedy showToastWithText:resp[@"msg"]];
            }else{
                NSLog(@"状态码异常");
                [self backToHome:responseObject];
            }
            return;
        }
        success(resp[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    return;
}


/**
 *  3.图片上传
 */
+(void)postUploadWithUrl:(NSString *)urlStr parameters:(id)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName fileType:(NSString *)fileType success:(void (^)(id responseObject))success fail:(void (^)(void))fail{
    
    
    [[ObjectTools sharedManager] POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:fileType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            NSLog(@"%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail();
        }
    }];
    
}

//MD5加密
+ (NSString *)MD5:(NSString *)mdStr
{
    const char *original_str = [mdStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

//获得当前时间戳
+ (NSString *)getNowTimeTimestamp{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
    
}


//token失效 返回主页面
+(void)backToHome:(id)responseObject{
//    NSInteger code = [responseObject[@"code"] integerValue];
//    if (code == 401 || code ==  601) {
//        UIViewController *vc = [ObjectTools visibleViewController];
//        vc.tabBarController.selectedIndex = 0;
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        [user setObject:@"0" forKey:@"LOGIN"];
//        [user synchronize];
//        [[ObjectTools sharedManager].requestSerializer setValue:RequestAuthGC forHTTPHeaderField:@"AuthGC"];
//        [[ObjectTools sharedManager].requestSerializer setValue:@"1" forHTTPHeaderField:@"FROMWAY"];
//
//        [vc.navigationController popToRootViewControllerAnimated:YES];
//        [DCSpeedy showToastWithText:[NSString stringWithFormat:@"%@",responseObject[@"msg"]]];
//    }
}


@end
