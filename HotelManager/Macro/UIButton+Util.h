//
//  UIButton+Util.h
//  Shine
//
//  Created by oops on 2018/10/31.
//  Copyright © 2018 oops. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Util)

typedef void(^clickBlock)(void);

+(UIButton *)buttonWithLocalImage:(nullable NSString *)image
                            title:(NSString *)title
                       titleColor:(nullable UIColor *)titleColor
                         fontSize:(CGFloat)fontSize
                            frame:(CGRect)frame
                            /*click:(clickBlock)clickBlock*/;

/**
 利用贝塞尔曲线设置圆角
 
 @param size 圆角尺寸
 */
- (void)dc_setUpBezierPathCircularLayersize:(CGSize)size;


/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
