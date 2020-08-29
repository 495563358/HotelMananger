//
//  OrderDetailDescCell.m
//  HotelManager
//
//  Created by oops on 2019/6/18.
//  Copyright © 2019 oops. All rights reserved.
//

#import "OrderDetailDescCell.h"

@interface OrderDetailDescCell()

@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UILabel *moneyL;
@property(nonatomic,strong)UILabel *descL;
@property(nonatomic,strong)UILabel *timeL;

@property (nonatomic,strong)NSMutableArray<UILabel *> *labelArr;

@end

@implementation OrderDetailDescCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}


-(void)createUI{
    self.contentView.backgroundColor = color(88, 188, 98, 1);
    
    UIView *whiteB = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 60)];
    whiteB.backgroundColor = [UIColor whiteColor];
    self.labelArr = [NSMutableArray array];
    NSArray *names = @[@"名称",@"单价",@"数量",@"总额"];
    CGFloat width = (ScreenWidth - 20)/4;
    for (int i = 0; i<names.count; i++) {
        
        UILabel *label = [UILabel labelWithText:names[i] fontSize:14 frame:CGRectMake(i * width, 0, width, 60) color:[UIColor grayColor] textAlignment:1];
        [whiteB addSubview:label];
        [self.labelArr addObject:label];
    }
    [self.contentView addSubview:whiteB];
}

-(void)setModel:(NSDictionary *)model{
    /*
     {
     date = "2019-06-03 11:00:00";
     days = 20190603;
     incomeAll = "456.0";
     oId = 201906021552468f94;
     }
     */
    if (_model != model) {
        _model = model;
        _labelArr[0].text = model[@"payName"];
        _labelArr[1].text = [NSString stringWithFormat:@"%@",model[@"amount"]];
        _labelArr[2].text = [NSString stringWithFormat:@"%@",model[@"count"]];
        _labelArr[3].text = [NSString stringWithFormat:@"%@",model[@"allAmount"]];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
