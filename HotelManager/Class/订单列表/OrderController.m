//
//  OrderController.m
//  HotelManager
//
//  Created by oops on 2019/6/18.
//  Copyright © 2019 oops. All rights reserved.
//

#import "OrderController.h"
#import "OrderDescCell.h"
#import "OrderNewDetailController.h"
#import "UICustomDatePicker.h"
#import "OPButton.h"

@interface OrderController()<UITableViewDelegate,UITableViewDataSource>{
    UILabel *_start;
    UILabel *_end;
}
@property (nonatomic,assign)NSInteger totalPage;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,copy)NSString *orderStatus;
@property(nonatomic,strong)UIView *headerV;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *typeView;

@property (nonatomic,strong)NSMutableArray *orderDatas;

@property (nonatomic,strong)NSMutableArray<OPButton *> *opbtns;
@property (nonatomic,strong)UILabel *emptyLab;

@end

@implementation OrderController

-(NSMutableArray *)orderDatas{
    if (!_orderDatas) {
        _orderDatas = [NSMutableArray array];
    }return _orderDatas;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"订单列表";
    UIButton *sliter = [UIButton buttonWithLocalImage:nil title:@"筛选" titleColor:[UIColor whiteColor] fontSize:16 frame:CGRectMake(0, 0, 50, 30)];
    [sliter addTarget:self action:@selector(sliterClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sliter];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight - kTabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = color(88, 188, 98, 1);
    _tableView.tableHeaderView = self.headerV;
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTabeleView)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(autoFooterRefresh)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.emptyLab = [UILabel labelWithText:@"老板,暂无订单哦" fontSize:18 frame:CGRectMake(0, ScreenHeight/2 - 20, ScreenWidth, 40) color:[UIColor whiteColor] textAlignment:1];
    [self.view addSubview:_emptyLab];
    
    [self.view addSubview:_tableView];
    self.typeView.hidden = YES;
    self.orderStatus = @"0";
    [self getRequestData];
    
    [self addObserver:self forKeyPath:@"orderDatas" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"orderDatas"]) {
        NSLog(@"%@",change[@"new"]);
    }
}

-(void)autoFooterRefresh{
    self.page ++;
    if(self.page > self.totalPage){
        [self.tableView.mj_footer removeFromSuperview];
    }else{
        [self getRequestData];
    }
    
}

-(UIView *)headerV{
    if (!_headerV) {
        _opbtns = [NSMutableArray array];
        NSArray *titles = @[@"全部",@"待完成",@"已完成",@"已取消"];
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
        for (int i = 0; i<titles.count; i++) {
            OPButton *btn = [[OPButton alloc] initWithFrame:CGRectMake(ScreenWidth*i/4, 0, ScreenWidth/4, 70)];
            btn.mainText = titles[i];
//            btn.countText = @"点击查询";
            btn.tag = i;
            [btn addTarget:self action:@selector(orderSelect:) forControlEvents:UIControlEventTouchUpInside];
            [header addSubview:btn];
            [_opbtns addObject:btn];
            if (i != 0) {
                btn.alpha = 0.6;
            }
        }
        _headerV = header;
    }
    return _headerV;
}



-(void)orderSelect:(OPButton *)sender{
    
    for (OPButton *temp in self.opbtns) {
        if (sender.tag == temp.tag) {
            temp.alpha = 1;
        }else{
            temp.alpha = 0.6;
        }
    }
    
    NSString *orderStatus = @"0";
    switch (sender.tag) {
        case 1:
            orderStatus = @"11";
            break;
        case 2:
            orderStatus = @"10";
            break;
        case 3:
            orderStatus = @"13";
            break;
        case 0:
            orderStatus = @"0";
        default:
            break;
    }
    if ([orderStatus isEqualToString:self.orderStatus]) {
        return;
    }else{
        self.orderStatus = orderStatus;
        self.page = 1;
        [self getRequestData];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(autoFooterRefresh)];
    }
}

-(void)sliterClick:(UIButton *)sender{
    self.typeView.hidden = NO;
}

-(UIView *)typeView{
    if (!_typeView) {
        _typeView = [[UIView alloc] initWithFrame:Screen_bounds];
        _typeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _typeView.hidden = YES;
        [MainWindow addSubview:_typeView];
        
        UIView *whiteback = [[UIView alloc]initWithFrame:CGRectMake(10, (ScreenHeight - 414/2)/2, ScreenWidth - 20, 414 * 0.5)];
        whiteback.backgroundColor = [UIColor whiteColor];
        [whiteback setCornerRadius:5];
        
        UILabel *lab1 = [UILabel labelWithText:@"订单筛选" fontSize:17 frame:CGRectMake(50, 0, ScreenWidth - 120, 45) color:[UIColor blackColor] textAlignment:1];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth - 20, 1)];
        line.backgroundColor = [UIColor grayColor];
        
        
        UILabel *lab2 = [UILabel labelWithText:@"日期" fontSize:16 frame:CGRectMake(10, 55, 100, 21) color:[UIColor grayColor] textAlignment:0];
        
        UILabel *lab3 = [UILabel labelWithText:@"起:" fontSize:15 frame:CGRectMake(10, 90, 35, 35) color:[UIColor whiteColor] textAlignment:1];
        [lab3 setCornerRadius:3];
        lab3.backgroundColor = color(88, 188, 98, 1);
        
        //当前月份
        NSString *firstday = [[NSDate date] stringWithFormat:@"yyyy"];
        NSString *beginTime = [NSString stringWithFormat:@"%@-01-01",firstday];
        UILabel *lab4 = [UILabel labelWithText:beginTime fontSize:15 frame:CGRectMake(40, 90, ScreenWidth/2 - 55 - 20, 35) color:[UIColor grayColor] textAlignment:1];
        [lab4 setCornerRadius:3];
        lab4.layer.borderColor = color(88, 188, 98, 1).CGColor;
        lab4.layer.borderWidth = 1;
        lab4.userInteractionEnabled = YES;
        [lab4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateTap:)]];
        
        UILabel *lab5 = [UILabel labelWithText:@"止:" fontSize:15 frame:CGRectMake((ScreenWidth - 20)/2 + 20, 90, 35, 35) color:[UIColor whiteColor] textAlignment:1];
        [lab5 setCornerRadius:3];
        lab5.backgroundColor = color(88, 188, 98, 1);
        
        NSString *todayStr = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
        UILabel *lab6 = [UILabel labelWithText:todayStr fontSize:15 frame:CGRectMake(lab5.x + 30, 90, ScreenWidth/2 - 55 - 20, 35) color:[UIColor grayColor] textAlignment:1];
        [lab6 setCornerRadius:3];
        lab6.layer.borderColor = color(88, 188, 98, 1).CGColor;
        lab6.layer.borderWidth = 1;
        lab6.userInteractionEnabled = YES;
        [lab6 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateTap:)]];
        
        _start = lab4;
        _end = lab6;
        
        UILabel *lab7 = [UILabel labelWithText:@"类型" fontSize:16 frame:CGRectMake(10, 150, 100, 21) color:[UIColor grayColor] textAlignment:0];
        
        
        UIButton *cancel = [UIButton buttonWithLocalImage:nil title:@"取消" titleColor:[UIColor blackColor] fontSize:16 frame:CGRectMake(10, whiteback.height - 55, ScreenWidth/2 - 30, 45)];
        [cancel setCornerRadius:3];
        [cancel setBackgroundColor:Color_mygray];
        [cancel addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *sure = [UIButton buttonWithLocalImage:nil title:@"确认" titleColor:[UIColor whiteColor] fontSize:16 frame:CGRectMake(10 + cancel.width + 10, whiteback.height - 55, ScreenWidth/2 - 30, 45)];
        [sure setCornerRadius:3];
        [sure setBackgroundColor:color(88, 188, 98, 1)];
        [sure addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [whiteback addSubview:lab1];
        [whiteback addSubview:lab2];
        [whiteback addSubview:lab3];
        [whiteback addSubview:lab4];
        [whiteback addSubview:lab5];
        [whiteback addSubview:lab6];
        [whiteback addSubview:lab7];
        [whiteback addSubview:line];
        [whiteback addSubview:cancel];
        [whiteback addSubview:sure];
        [_typeView addSubview:whiteback];
        
    }
    return _typeView;
}


-(void)cancelClick:(UIButton *)sender{
    self.typeView.hidden = YES;
}

-(void)sureClick:(UIButton *)sender{
    self.typeView.hidden = YES;
    _page = 1;
    //请求数据
    [self getRequestData];
}

-(void)dateTap:(UITapGestureRecognizer *)tap{
    
    UILabel *label = (UILabel *)tap.view;
    
    [UICustomDatePicker showCustomDatePickerAtView:self.typeView choosedDateBlock:^(NSDate *date) {//点击确认打印
        NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
        [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
        
        NSString *timeString = [formatter_minDate stringFromDate:date];
        label.text = timeString;
    } cancelBlock:^{//点击取消打印
        NSLog(@"点击了取消");
    }];
}

-(void)reloadTabeleView{
    
    NSString *firstday = [[NSDate date] stringWithFormat:@"yyyy"];
    NSString *currentT = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    
    NSString *beginTime = [NSString stringWithFormat:@"%@-01-01",firstday];
    _start.text = beginTime;
    _end.text = currentT;
    _page = 1;
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(autoFooterRefresh)];
    [self getRequestData];
}

-(void)getRequestData{
    
    NSString *beginTime = [NSString stringWithFormat:@"%@ 00:00:00",_start.text];
    NSString *endTime = [NSString stringWithFormat:@"%@ 23:59:59",_end.text];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{@"beginTime":beginTime,@"endTime":endTime}];
    [param setValue:@"10" forKey:@"pageSize"];
    [param setValue:[NSString stringWithFormat:@"%ld",self.page] forKey:@"pageIndex"];
    
    if (![self.orderStatus isEqualToString:@"0"]) {
        [param setValue:self.orderStatus forKey:@"orderStatus"];
    }
    
    [BaseocHttpService postRequest:[baseAddress stringByAppendingString:getOrderPageByCondition] andParagram:param rightBlock:^(id responseObject) {
        NSLog(@"getOrderPageByCondition = %@",responseObject);
        
        if (self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        if (self.tableView.mj_footer.isRefreshing) {
            [self.tableView.mj_footer endRefreshing];
        }
        if (self.page == 1) {
            [self.orderDatas removeAllObjects];
        }
        self.totalPage = [responseObject[@"totalPage"] integerValue];
        [self.orderDatas addObjectsFromArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self reloadHeaderCount:responseObject[@"totalCount"]];
        
        if (!self.orderDatas.count) {
            [self.view bringSubviewToFront:self.emptyLab];
        }else{
            [self.view sendSubviewToBack:self.emptyLab];
        }
        
        if ([responseObject[@"list"] count] != 10) {
            [self.tableView.mj_footer removeFromSuperview];
        }
    } errorBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        if (self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        if (self.tableView.mj_footer.isRefreshing) {
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

-(void)reloadHeaderCount:(NSString *)countStr{
    if ([self.orderStatus isEqualToString:@"0"]) {
        [self.opbtns[0] setCountText:[NSString stringWithFormat:@"%@",countStr]];
    }else if ([self.orderStatus isEqualToString:@"11"]) {
        [self.opbtns[1] setCountText:[NSString stringWithFormat:@"%@",countStr]];
    }else if ([self.orderStatus isEqualToString:@"10"]) {
        [self.opbtns[2] setCountText:[NSString stringWithFormat:@"%@",countStr]];
    }else if ([self.orderStatus isEqualToString:@"13"]) {
        [self.opbtns[3] setCountText:[NSString stringWithFormat:@"%@",countStr]];
    }
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderDatas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"OrderDescCell";//以indexPath来唯一确定cell
    
    OrderDescCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[OrderDescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.orderDatas[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderNewDetailController *vc = [OrderNewDetailController new];
    vc.orderId = self.orderDatas[indexPath.row][@"id"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
