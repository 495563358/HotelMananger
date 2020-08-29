//
//  UIImageView+Util.h
//  CarMayor
//
//  Created by zjcheshi.com on 16/3/2.
//  Copyright © 2016年 SKY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Util)

/*
 设置本地图片 切圆角
 cornerRadius传0表示切成圆
 */
- (void)setLocaImage:(UIImage *)image withCornerRadius:(CGFloat)cornerRadius;

/*
 设置网络图片 切圆角
 cornerRadius传0表示切成圆
 */
- (void)setUrlImage:(NSString *)url andcornerRadius:(CGFloat)cornerRadius;
@end
