//
//  OrderNewDetailController.m
//  HotelManager
//
//  Created by oops on 2019/10/18.
//  Copyright © 2019 oops. All rights reserved.
//

#import "OrderNewDetailController.h"
#import "OrderDetailDescCell.h"

@interface OrderNewDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSDictionary *resultData;
@property (nonatomic,strong)UIView *headerView;
@property (nonatomic,strong)UIView *footerView;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation OrderNewDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    [self getRequestData];
}

-(void)getRequestData{
    [BaseocHttpService postRequest:[baseAddress stringByAppendingString:getOrderInfoById] andParagram:@{@"orderId":self.orderId} rightBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.resultData = responseObject;
        self.requestData = responseObject[@"orderDetails"];
        [self reloadUI];
    } errorBlock:^(id responseObject) {
        
    }];
}

-(void)reloadUI{
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    CGFloat hh = 15;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10,hh, ScreenWidth - 20, 150)];
    view1.backgroundColor = [UIColor whiteColor];
    [view1 setCornerRadius:10];
    
    UIView *grayV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 20, 50)];
    grayV.backgroundColor = Color_mygray;
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn1 setTitle:@"房间信息" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"fangjian"] forState:UIControlStateNormal];
    [btn1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8];
    [grayV addSubview:btn1];
    
    NSString *hourseNumber = [NSString stringWithFormat:@"房间号:%@",_resultData[@"hourseNumber"]];
    UILabel *roominfoLab1 = [UILabel labelWithText:hourseNumber fontSize:16 frame:CGRectMake(10, 50, ScreenWidth/2, 50) color:[UIColor blackColor] textAlignment:0];
    
    NSString *orderStatusDesc = nil;
    NSInteger orderStatus = [_resultData[@"orderStatus"] integerValue];
    if (orderStatus == 10) {
        orderStatusDesc = @"已完成";
    }else if (orderStatus == 11) {
        orderStatusDesc = @"待完成";
    }else if (orderStatus == 13) {
        orderStatusDesc = @"已取消";
    }
    UILabel *roominfoLab2 = [UILabel labelWithText:orderStatusDesc fontSize:16 frame:CGRectMake(view1.width - 100, 50, 90, 50) color:[UIColor blackColor] textAlignment:2];
    
    
    NSString *orderStartDate = _resultData[@"orderStartDate"];
    NSArray *startArr = [orderStartDate componentsSeparatedByString:@"-"];
    NSString *startTime = [NSString stringWithFormat:@"%@-%@",startArr[1],[startArr[2] componentsSeparatedByString:@" "][0]];
    NSString *orderEndTime = _resultData[@"orderEndTime"];
    NSArray *endArr = [orderEndTime componentsSeparatedByString:@"-"];
    NSString *endTime = [NSString stringWithFormat:@"%@-%@",endArr[1],[endArr[2] componentsSeparatedByString:@" "][0]];
    NSString *timeT = [NSString stringWithFormat:@"%@至%@ 共%@晚",startTime,endTime,_resultData[@"orderCount"]];
    
    UILabel *roominfoLab3 = [UILabel labelWithText:timeT fontSize:16 frame:CGRectMake(10, 100, ScreenWidth-40, 50) color:[UIColor blackColor] textAlignment:0];
    
    
    NSString *moneyText = [NSString stringWithFormat:@"￥%@",_resultData[@"orderRecAmount"]];
    
    UILabel *roominfoLab4 = [UILabel labelWithText:moneyText fontSize:16 frame:CGRectMake(view1.width - 100, 100, 90, 50) color:[UIColor blackColor] textAlignment:2];
    
    [view1 addSubview:grayV];
    [view1 addSubview:roominfoLab1];
    [view1 addSubview:roominfoLab2];
    [view1 addSubview:roominfoLab3];
    [view1 addSubview:roominfoLab4];
    
    
    hh += 165;
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(10,hh, ScreenWidth - 20, 100)];
    view2.backgroundColor = [UIColor whiteColor];
    [view2 setCornerRadius:10];
    
    UILabel *lab21 = [UILabel labelWithText:@"渠道来源" fontSize:16 frame:CGRectMake(10, 0, 100, 50) color:[UIColor blackColor] textAlignment:0];
    
    UILabel *lab22 = [UILabel labelWithText:_resultData[@"sourceWay"] fontSize:16 frame:CGRectMake(view2.width - 150, 0, 140, 50) color:[UIColor grayColor] textAlignment:2];
    
    UILabel *lab23 = [UILabel labelWithText:@"订单号" fontSize:16 frame:CGRectMake(10, 50, 100, 50) color:[UIColor blackColor] textAlignment:0];
    
    UILabel *lab24 = [UILabel labelWithText:_orderId fontSize:16 frame:CGRectMake(view2.width - 250,50, 240, 50) color:[UIColor grayColor] textAlignment:2];
    [view2 addSubview:lab21];
    [view2 addSubview:lab22];
    [view2 addSubview:lab23];
    [view2 addSubview:lab24];
    
    hh += 115;
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(10,hh, ScreenWidth - 20, 150)];
    view3.backgroundColor = [UIColor whiteColor];
    [view3 setCornerRadius:10];
    
    NSArray *arr1 = @[@"订单总额",@"实收金额",@"支出金额"];
    NSArray *arr2 = @[_resultData[@"orderRecAmount"],_resultData[@"orderActAmount"],_resultData[@"payAmount"]];
    for (int i = 0; i<3; i++) {
        UILabel *desc1 = [UILabel labelWithText:arr1[i] fontSize:16 frame:CGRectMake(10, i*50, 100, 50) color:[UIColor blackColor] textAlignment:0];
        UILabel *money1 = [UILabel labelWithText:[NSString stringWithFormat:@"￥%@",arr2[i]] fontSize:16 frame:CGRectMake(view3.width - 150, 50*i, 140, 50) color:[UIColor blackColor] textAlignment:2];
        [view3 addSubview:desc1];
        [view3 addSubview:money1];
    }
    hh += 150;
    [_headerView addSubview:view1];
    [_headerView addSubview:view2];
    [_headerView addSubview:view3];
    
    if (self.requestData && self.requestData.count) {
        
        hh += 15;
        UIView *detailV = [[UIView alloc] initWithFrame:CGRectMake(10, hh, ScreenWidth - 20, 110)];
        detailV.backgroundColor = [UIColor whiteColor];
        [detailV setCornerRadius:10];
        UILabel *title2 = [UILabel labelWithText:@"开支详情" fontSize:16 frame:CGRectMake(10, 0, 100, 50) color:[UIColor blackColor] textAlignment:0];
        
        [detailV addSubview:title2];
        hh += 50;
        
        NSArray *names = @[@"名称",@"单价",@"数量",@"总额"];
        CGFloat width = (ScreenWidth - 20)/4;
        for (int i = 0; i<4; i++) {
            UILabel *label = [UILabel labelWithText:names[i] fontSize:14 frame:CGRectMake(i * width, 50, width, 50) color:[UIColor grayColor] textAlignment:1];
            [detailV addSubview:label];
        }
        hh += 50;
        [_headerView addSubview:detailV];
    }
    _headerView.mj_h = hh;
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(10,15, ScreenWidth - 20, 150)];
    _footerView.backgroundColor = [UIColor whiteColor];
    [_footerView setCornerRadius:10];
    
    UIView *grayVfoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 20, 50)];
    grayVfoot.backgroundColor = Color_mygray;
    
    UIButton *btn1foot = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    btn1foot.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn1foot setTitle:@"订单备注" forState:UIControlStateNormal];
    [btn1foot setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1foot setImage:[UIImage imageNamed:@"weibiaoti-"] forState:UIControlStateNormal];
    [btn1foot layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8];
    [grayVfoot addSubview:btn1foot];
    
    [_footerView addSubview:grayVfoot];
    
    NSString *orderDesctext = [NSString stringWithFormat:@"%@",_resultData[@"orderDesc"]];
    if ([orderDesctext isEqualToString:@"<null>"]) {
        orderDesctext = @"暂无说明";
    }
    UILabel *orderDesc = [UILabel labelWithText:orderDesctext fontSize:16 frame:CGRectMake(10, 60, _footerView.width - 20, 100) color:[UIColor blackColor] textAlignment:0];
    [orderDesc sizeToFit];
    [_footerView addSubview:orderDesc];
    
    [self createTable];
    
}

-(void)createTable{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth , ScreenHeight - SafeAreaTopHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = color(88, 188, 98, 1);
    _tableView.tableHeaderView = self.headerView;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
    [footer addSubview:_footerView];
    _tableView.tableFooterView = footer;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.requestData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"OrderDetailDescCell";//以indexPath来唯一确定cell
    
    OrderDetailDescCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[OrderDetailDescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.requestData[indexPath.row];
    return cell;
}

@end
