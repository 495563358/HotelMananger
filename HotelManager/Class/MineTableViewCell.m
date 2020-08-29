//
//  MineTableViewCell.m
//  HotelManager
//
//  Created by oops on 2019/6/20.
//  Copyright © 2019 oops. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    self.backgroundColor = color(88, 188, 98, 1);
    UIView *whiteB = [[UIView alloc] initWithFrame:CGRectMake(10, 8, ScreenWidth - 20, 45)];
    [whiteB setCornerRadius:10];
    whiteB.backgroundColor = [UIColor whiteColor];
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 25, 25)];
    
    self.descL = [UILabel labelWithText:@"" fontSize:15 frame:CGRectMake(60, 0, ScreenWidth - 150, 45) color:[UIColor blackColor] textAlignment:0];
    
    [whiteB addSubview:_imageV];
    [whiteB addSubview:_descL];
    [self.contentView addSubview:whiteB];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
