//
//  OrderDescCell.m
//  HotelManager
//
//  Created by oops on 2019/6/18.
//  Copyright © 2019 oops. All rights reserved.
//

#import "OrderDescCell.h"

@interface OrderDescCell()

@property(nonatomic,strong)UILabel *sourceWay;
@property(nonatomic,strong)UILabel *orderStatus;
@property(nonatomic,strong)UILabel *hourseNumber;
@property(nonatomic,strong)UILabel *payAmount;
@property(nonatomic,strong)UILabel *ordertime;

@end

@implementation OrderDescCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    self.contentView.backgroundColor = color(88, 188, 98, 1);
    UIView *whiteBack = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 140)];
    whiteBack.backgroundColor = [UIColor whiteColor];
    [whiteBack setCornerRadius:5];
    
    
    self.sourceWay = [UILabel labelWithText:@"订单来源" fontSize:16 frame:CGRectMake(10, 10, ScreenWidth/2, 50) color:[UIColor blackColor] textAlignment:0];
    self.orderStatus = [UILabel labelWithText:@"已确认" fontSize:16 frame:CGRectMake(whiteBack.width - 100, 10, 80, 50) color:[UIColor blackColor] textAlignment:2];
    
    self.hourseNumber = [UILabel labelWithText:@"test120" fontSize:16 frame:CGRectMake(10, 65, ScreenWidth/2, 20) color:[UIColor grayColor] textAlignment:0];
    self.payAmount = [UILabel labelWithText:@"金额" fontSize:16 frame:CGRectMake(whiteBack.width - 220, 65, 200, 20) color:[UIColor blackColor] textAlignment:2];
    self.ordertime = [UILabel labelWithText:@"入离:10-15" fontSize:16 frame:CGRectMake(10, 100, whiteBack.width - 20, 20) color:[UIColor grayColor] textAlignment:0];
    
    [self.contentView addSubview:whiteBack];
    [whiteBack addSubview:_sourceWay];
    [whiteBack addSubview:_orderStatus];
    [whiteBack addSubview:_hourseNumber];
    [whiteBack addSubview:_payAmount];
    [whiteBack addSubview:_ordertime];
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
        _sourceWay.text = model[@"sourceWay"];
        NSInteger orderStatus = [model[@"orderStatus"] integerValue];
        if (orderStatus == 10) {
            _orderStatus.text = @"已完成";
        }else if (orderStatus == 11) {
            _orderStatus.text = @"待完成";
        }else if (orderStatus == 13) {
            _orderStatus.text = @"已取消";
        }
        _hourseNumber.text = [NSString stringWithFormat:@"房间号:%@",model[@"hourseNumber"]];
        
        NSString *moneyText = [NSString stringWithFormat:@"￥%@",model[@"orderRecAmount"]];
        _payAmount.attributedText = [self getMoneyText:moneyText];
        
        NSString *orderStartDate = model[@"orderStartDate"];
        NSArray *startArr = [orderStartDate componentsSeparatedByString:@"-"];
        NSString *startTime = [NSString stringWithFormat:@"%@-%@",startArr[1],[startArr[2] componentsSeparatedByString:@" "][0]];
        NSString *orderEndTime = model[@"orderEndTime"];
        NSArray *endArr = [orderEndTime componentsSeparatedByString:@"-"];
        NSString *endTime = [NSString stringWithFormat:@"%@-%@",endArr[1],[endArr[2] componentsSeparatedByString:@" "][0]];
        NSString *timeT = [NSString stringWithFormat:@"入离:%@至%@",startTime,endTime];
        _ordertime.text = timeT;
        
    }
}

-(NSMutableAttributedString *)getMoneyText:(NSString *)text{
    
    NSString *protStr = [NSString stringWithFormat:@"总额:%@",text];
    
    NSRange range = [protStr rangeOfString:text];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:protStr];
    [attrStr addAttribute:NSForegroundColorAttributeName value:SystemColor range:range];
    return attrStr;
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
