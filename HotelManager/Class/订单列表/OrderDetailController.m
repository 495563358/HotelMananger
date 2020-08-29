//
//  OrderDetailController.m
//  HotelManager
//
//  Created by oops on 2019/6/18.
//  Copyright © 2019 oops. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailDescCell.h"

@interface OrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSDictionary *resultData;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation OrderDetailController

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
        self.requestData = responseObject[@"orderItems"];
        [self reloadUI];
    } errorBlock:^(id responseObject) {
        
    }];
}

-(void)reloadUI{
    
    CGFloat hh = 0;
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, hh)];
    UILabel *title1 = [UILabel labelWithText:@"订单信息:" fontSize:16 frame:CGRectMake(15, 10, 100, 20) color:[UIColor blackColor] textAlignment:0];
    
    [headerV addSubview:title1];
    hh += 60;
    
    
    NSArray *arr1 = @[@"订单号:",@"房间信息:",@"创建时间:",@"订单金额:",@"实收金额:",@"支出金额:",@"订单来源:",@"支付方式:"];
    NSArray *arr2 = @[_resultData[@"oId"],_resultData[@"hNumber"],_resultData[@"oDate"],_resultData[@"oRecAmount"],_resultData[@"orderActAmount"],_resultData[@"payAmount"],_resultData[@"sourceWay"],_resultData[@"payWay"]];
    
    for (int i = 0; i < arr1.count; i++) {
        UILabel *label = [UILabel labelWithText:[NSString stringWithFormat:@"%@ %@",arr1[i],arr2[i]] fontSize:14 frame:CGRectMake(30, hh, ScreenWidth - 60, 20) color:[UIColor grayColor] textAlignment:0];
        hh += 30;
        [headerV addSubview:label];
        
    }
    
    if (self.requestData && self.requestData.count) {
        
        hh += 30;
        UILabel *title2 = [UILabel labelWithText:@"开支详情:" fontSize:16 frame:CGRectMake(15, hh, 100, 20) color:[UIColor blackColor] textAlignment:0];
        
        [headerV addSubview:title2];
        hh += 50;
        
        NSArray *names = @[@"名称",@"金额",@"描述",@"时间",@"数量"];
        CGFloat width = (ScreenWidth - 60)/5;
        for (int i = 0; i<5; i++) {
            UILabel *label = [UILabel labelWithText:names[i] fontSize:14 frame:CGRectMake(30 + i * width, hh, width, 20) color:[UIColor grayColor] textAlignment:1];
            [headerV addSubview:label];
        }
        hh += 30;
        
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight - kTabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.bounces = NO;
    headerV.frame = CGRectMake(0, SafeAreaTopHeight, ScreenWidth, hh);
    _tableView.tableHeaderView = headerV;
    [self.view addSubview:_tableView];
//    [self.view addSubview:headerV];
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
