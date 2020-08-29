
//
//  ProfitController.m
//  HotelManager
//
//  Created by oops on 2019/6/18.
//  Copyright © 2019 oops. All rights reserved.
//

#import "ProfitController.h"
#import "TNCustomSegment.h"

@interface ProfitController()<TNCustomSegmentDelegate>

@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)NSMutableArray<UILabel *> *labArr;
@property(nonatomic,assign)NSInteger selectIndex;

@end

@implementation ProfitController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"收益概览";
    [self createUI];
    
    //今日收益
    [self todayProf];
    [self getRequestData:[self currentMonthParam]];
}

-(void)createUI{
    
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - kNavAndTabHeight)];
    _scroll.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshPage)];
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * 13/17)];
    headerV.backgroundColor = color(88, 188, 98, 1);
    [_scroll addSubview:headerV];
    
    self.descLab = [UILabel labelWithText:@"今日总收入(元)" fontSize:13 frame:CGRectMake(0, headerV.height * 0.3, ScreenWidth, 30) color:[UIColor whiteColor] textAlignment:1];
    self.label1 = [UILabel labelWithText:@"0.0" fontSize:22 frame:CGRectMake(0, headerV.height * 0.4, ScreenWidth, 50) color:[UIColor whiteColor] textAlignment:1];
    
//    UILabel *lab2 = [UILabel labelWithText:@"本月累计(元)" fontSize:13 frame:CGRectMake(0, headerV.height * 0.5, ScreenWidth, 30) color:[UIColor whiteColor] textAlignment:1];
//    self.label2 = [UILabel labelWithText:@"0.0" fontSize:14 frame:CGRectMake(0, headerV.height * 0.6, ScreenWidth, 30) color:[UIColor whiteColor] textAlignment:1];
    
    NSArray *items = @[@"今日",@"昨日",@"本月"];
    TNCustomSegment *segment = [[TNCustomSegment alloc] initWithItems:items withFrame:CGRectMake(ScreenWidth*3/5, headerV.height - 45, ScreenWidth*2/5 - 15, 30) withSelectedColor:[UIColor whiteColor] withNormolColor:color(88, 188, 98, 1) withFont:[UIFont systemFontOfSize:14]];
    segment.delegate = self;
    segment.selectedIndex = 0;
    
    [headerV addSubview:_descLab];
    [headerV addSubview:_label1];
//    [headerV addSubview:lab2];
//    [headerV addSubview:_label2];
    [headerV addSubview:segment];
    
    
    
    self.labArr = [NSMutableArray array];
    NSArray *names = @[@"入住天数(天)",@"支出总额(元)",@"入住率(%)",@"总收益(元)"];
    
    CGFloat startY = headerV.bottom;
    
    for (int i = 0; i < 4; i++) {
        int x = i%2;
        int y = i/2;
        UILabel *lab = [UILabel labelWithText:names[i] fontSize:18 frame:CGRectMake(x*ScreenWidth/2, startY + 30 + y*100, ScreenWidth/2, 30) color:[UIColor grayColor] textAlignment:1];
        [_scroll addSubview:lab];
        
        UILabel *lab2 = [UILabel labelWithText:@"0.0" fontSize:15 frame:CGRectMake(x*ScreenWidth/2, startY + 70 + y*100, ScreenWidth/2, 30) color:SystemColor textAlignment:1];
        [_scroll addSubview:lab2];
        [self.labArr addObject:lab2];
        
    }
    [self.view addSubview:_scroll];
    
}

-(void)refreshPage{
    if (_selectIndex == 0) {
        [self todayProf];
    }else if(_selectIndex == 1){
        [self yestedayProf];
    }else if (_selectIndex == 2){
        [self currentMonthProf];
    }
    [self getRequestData:[self currentMonthParam]];
    
}

-(NSDictionary *)todayParam{
    
    UserModel *model = [(AppDelegate *)[UIApplication sharedApplication].delegate userModel];
    NSString *ownerId = model.ID;
    
    NSString *time = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    
    NSString *beginTime = [NSString stringWithFormat:@"%@ 00:00:00",time];
    NSString *endTime = [NSString stringWithFormat:@"%@ 23:59:59",time];
    
    NSDictionary *param = @{@"ownerId":ownerId,@"beginTime":beginTime,@"endTime":endTime};
    return param;
}

-(NSDictionary *)yestedatParam{
    
    UserModel *model = [(AppDelegate *)[UIApplication sharedApplication].delegate userModel];
    NSString *ownerId = model.ID;
    
    NSString *time = [[[NSDate date] dateByAddingDays:-1] stringWithFormat:@"yyyy-MM-dd"];
    
    NSString *beginTime = [NSString stringWithFormat:@"%@ 00:00:00",time];
    NSString *endTime = [NSString stringWithFormat:@"%@ 23:59:59",time];
    
    NSDictionary *param = @{@"ownerId":ownerId,@"beginTime":beginTime,@"endTime":endTime};
    return param;
}


-(NSDictionary *)currentMonthParam{
    
    UserModel *model = [(AppDelegate *)[UIApplication sharedApplication].delegate userModel];
    NSString *ownerId = model.ID;
    //当前月份
    NSString *firstday = [[NSDate date] stringWithFormat:@"yyyy-MM"];
    NSString *currentT = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *beginTime = [NSString stringWithFormat:@"%@-01 00:00:00",firstday];
    NSString *endTime = currentT;
    
    NSDictionary *param = @{@"ownerId":ownerId,@"beginTime":beginTime,@"endTime":endTime};
    return param;
}

#pragma mark - TNCustomsegmentDelegate
- (void)segment:(TNCustomSegment *)segment didSelectedIndex:(NSInteger)selectIndex{
    self.selectIndex = selectIndex;
    if (selectIndex == 0) {
        [self todayProf];
    }else if(selectIndex == 1){
        [self yestedayProf];
    }else if (selectIndex == 2){
        [self currentMonthProf];
    }
}

-(void)getRequestData:(NSDictionary *)param{
    
    //请求下面的数据
    [BaseocHttpService postRequest:[baseAddress stringByAppendingString:getDateByCondition] andParagram:param rightBlock:^(id responseObject) {
        
        self.labArr[0].text = [NSString stringWithFormat:@"%@",responseObject[@"count"]];
        self.labArr[1].text = [NSString stringWithFormat:@"%@",responseObject[@"extraCosts"]];
        self.labArr[2].text = [NSString stringWithFormat:@"%@",responseObject[@"houseRate"]];
        self.labArr[3].text = [NSString stringWithFormat:@"%@",responseObject[@"incomeAll"]];
        [self.scroll.mj_header endRefreshing];
    } errorBlock:^(id responseObject) {
        
        [self.scroll.mj_header endRefreshing];
    }];
    
    
}

//今日收益
-(void)todayProf{
    NSDictionary *param = [self todayParam];
    [BaseocHttpService postRequest:[baseAddress stringByAppendingString:getIncomeByCondition] andParagram:param rightBlock:^(id responseObject) {
        self.descLab.text = @"今日总收入(元)";
        self.label1.text = [NSString stringWithFormat:@"%@",responseObject];
        
    } errorBlock:^(id responseObject) {
        
    }];
}

//昨日收益
-(void)yestedayProf{
    NSDictionary *param = [self yestedatParam];
    [BaseocHttpService postRequest:[baseAddress stringByAppendingString:getIncomeByCondition] andParagram:param rightBlock:^(id responseObject) {
        self.descLab.text = @"昨日总收入(元)";
        self.label1.text = [NSString stringWithFormat:@"%@",responseObject];
        
    } errorBlock:^(id responseObject) {
        
    }];
}

//本月收益
-(void)currentMonthProf{
    
    NSDictionary *param = [self currentMonthParam];
    [BaseocHttpService postRequest:[baseAddress stringByAppendingString:getIncomeByCondition] andParagram:param rightBlock:^(id responseObject) {
        self.descLab.text = @"本月总收入(元)";
        self.label1.text = [NSString stringWithFormat:@"%@",responseObject];
    } errorBlock:^(id responseObject) {
        
    }];
}

@end
