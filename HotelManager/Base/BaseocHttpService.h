//
//  BaseocHttpService.h
//  SmartHome
//
//  Created by Smart house on 2018/4/4.
//  Copyright © 2018年 Verb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseocHttpService : NSObject

typedef void (^successBackBlock) (id responseObject);

typedef void (^rightBackBlock) (id responseObject);
typedef void (^errorBackBlock) (id responseObject);
typedef void (^failureBackBlock) (id responseObject);

/*
 GET 返回所有情况 正确错误失败
    rightBackBlock
    errorBackBlock
    failureBackBlock
 */
+(void)getRequest:(NSString *)urlStr andParagram:(id)paragram rightBlock:(rightBackBlock)right errorBlock:(errorBackBlock)error failur:(failureBackBlock)failure;

/*
 GET 返回网络正常的情况 正确代码和错误代码
    rightBackBlock
    errorBackBlock
 */
+(void)getRequest:(NSString *)urlStr andParagram:(id)paragram rightBlock:(rightBackBlock)right errorBlock:(errorBackBlock)error;

/*
 GET 只返回正确代码 code = 200
 rightBackBlock
 */
+(void)getRequestWithoutError:(NSString *)urlStr andParagram:(id)paragram success:(void (^)(id responseObject))success;


/*
 POST 返回网络正常的情况 正确代码和错误代码
 */
+(void)postRequest:(NSString *)urlStr andParagram:(id)paragram rightBlock:(rightBackBlock)right errorBlock:(errorBackBlock)error;

/*
 只返回code == 200结果
 */
+(void)postRequestWithoutError:(NSString *)urlStr andParagram:(id)paragram success:(void (^)(id responseObject))success;



+(void)postUploadWithUrl:(NSString *)urlStr parameters:(id)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName fileType:(NSString *)fileType success:(void (^)(id responseObject))success fail:(void (^)(void))fail;


+ (NSString *)getNowTimeTimestamp;

@end
