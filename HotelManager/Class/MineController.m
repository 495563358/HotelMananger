//
//  MineController.m
//  HotelManager
//
//  Created by oops on 2019/6/18.
//  Copyright © 2019 oops. All rights reserved.
//

#import "MineController.h"
#import "MineTableViewCell.h"
#import "ChangePwdController.h"
#import "BusinessAgentController.h"
#import "AboutUSController.h"

@interface MineController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation MineController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight - kTabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = color(88, 188, 98, 1);
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"MineTableViewCell";//以indexPath来唯一确定cell
    
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        cell.imageV.image = [UIImage imageNamed:@"shezhi"];
        cell.descL.text = @"修改密码";
    }else if(indexPath.row == 1){
        cell.imageV.image = [UIImage imageNamed:@"jingli"];
        cell.descL.text = @"我的商务经理";
        
    }else if(indexPath.row == 2){
        cell.imageV.image = [UIImage imageNamed:@"Icon_wode"];
        cell.descL.text = @"关于我们";
    }else if(indexPath.row == 3){
        cell.imageV.image = [UIImage imageNamed:@"tuichu"];
        cell.descL.text = @"退出登录";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ChangePwdController *vc = [ChangePwdController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(indexPath.row == 1){
        BusinessAgentController *vc = [BusinessAgentController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(indexPath.row == 2){
        AboutUSController *vc = [AboutUSController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(indexPath.row == 3){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EXITSUCCESS" object:nil];
        
    }
}

@end
