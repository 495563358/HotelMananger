//
//  OPButton.m
//  HotelManager
//
//  Created by oops on 2019/10/16.
//  Copyright © 2019 oops. All rights reserved.
//

#import "OPButton.h"

@interface OPButton()
@property(nonatomic,strong)UILabel *mainLab;
@property(nonatomic,strong)UILabel *countLab;

@end

@implementation OPButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.mainLab = [UILabel labelWithText:@"" fontSize:16 frame:CGRectMake(0, 0, self.width, self.height) color:[UIColor whiteColor] textAlignment:1];
    
    self.countLab = [UILabel labelWithText:@"" fontSize:16 frame:CGRectMake(0, self.height/2, self.width, self.height/3) color:[UIColor whiteColor] textAlignment:1];
    
    [self addSubview:_mainLab];
    [self addSubview:_countLab];
}

-(void)setMainText:(NSString *)mainText{
    _mainLab.text = mainText;
}

-(void)setCountText:(NSString *)countText{
//    _countLab.text = countText;
//    _mainLab.mj_h = self.height/2;
}

@end
