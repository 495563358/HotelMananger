//
//  UILabel+Util.m
//
//  Created by SKY
//  Copyright © 翊sky. All rights reserved.
//

#import "UILabel+Util.h"

@implementation UILabel (Util)

+(UILabel *)labelWithText:(NSString *)string
                 fontSize:(CGFloat)fontSize
                    frame:(CGRect)frame
                    color:(UIColor *)color
            textAlignment:(int)textAlignment{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = string;
    label.numberOfLines = 0;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}



@end
