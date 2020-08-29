//
//  UIImage+Util.h
//  yicai
//
//  Created by oops on 2018/12/4.
//  Copyright © 2018 defuya. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage(Util)

/**
 *  返回圆形图片
 */
- (instancetype)circleImage;

+ (instancetype)circleImage:(NSString *)name;

//返回圆角图片
- (instancetype)cornerRadiusImageWithcornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
