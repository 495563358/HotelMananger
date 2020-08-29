//
//  UIImage+Util.m
//  yicai
//
//  Created by oops on 2018/12/4.
//  Copyright © 2018 defuya. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage(Util)

- (instancetype)circleImage{
    
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    // 绘制图片
    [self drawInRect:rect];
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

- (instancetype)cornerRadiusImageWithcornerRadius:(CGFloat)cornerRadius {
    
    if (cornerRadius == 0) {
        cornerRadius = self.size.height/2;
    }
    
    CGSize size = self.size;
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    // 获取绘制圆的半径、宽、高 的一个区域
    CGFloat radius = cornerRadius;
    CGFloat width = radius * 2;
    CGFloat height = width;
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // 使用 UIBezierPath 路径裁切，注意：先设置裁切路径，再绘制图像
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    // 添加到裁切路径
    [bezierPath addClip];
    
    // 将图片绘制到裁切好的区域内
    [self drawInRect:rect];
    
    // 从上下文获取当前绘制成圆形的图片
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    // 赋值给 iconView.image
    return resImage;
}

+ (instancetype)circleImage:(NSString *)name{
    
    return [[self imageNamed:name] circleImage];
}

@end
