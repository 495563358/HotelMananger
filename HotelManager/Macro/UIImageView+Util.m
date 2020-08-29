//
//  UIImageView+Util.m
//  CarMayor
//
//  Created by zjcheshi.com on 16/3/2.
//  Copyright © 2016年 SKY. All rights reserved.
//

#import "UIImageView+Util.h"
#import "UIImage+Util.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Util)

- (void)setLocaImage:(UIImage *)image withCornerRadius:(CGFloat)cornerRadius {
    
    if (cornerRadius == 0) {
        cornerRadius = self.height/2;
    }
    self.image = image;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius * 2, cornerRadius * 2)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

//网络Url图片圆角
- (void)setUrlImage:(NSString *)url andcornerRadius:(CGFloat)cornerRadius
{
    if (cornerRadius == 0) {
        cornerRadius = self.bounds.size.height/2;
    }
    WEAKSELF;
    [self sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakSelf setLocaImage:image withCornerRadius:cornerRadius];
    }];
}

@end
