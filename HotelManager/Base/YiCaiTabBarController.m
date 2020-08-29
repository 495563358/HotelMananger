//
//  YiCaiTabBarController.m
//  HotelManager
//
//  Created by oops on 2019/6/18.
//  Copyright © 2019 oops. All rights reserved.
//

#import "YiCaiTabBarController.h"

#import "YiCaiNavigationController.h"
#import "OrderController.h"
#import "ProfitController.h"
#import "MineController.h"

@interface YiCaiTabBarController ()

@end

@implementation YiCaiTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = color(88, 188, 98, 1);
    OrderController *order = [OrderController new];
    YiCaiNavigationController *orderNav = [[YiCaiNavigationController alloc] initWithRootViewController:order];
    orderNav.tabBarItem.title = NSLocalizedString(@"收益明细", nil);
    UIImage *select = [UIImage imageNamed:@"hall2"];
    orderNav.tabBarItem.image = select;
    
    ProfitController *prof = [ProfitController new];
    YiCaiNavigationController *profNav = [[YiCaiNavigationController alloc] initWithRootViewController:prof];
    profNav.tabBarItem.title = NSLocalizedString(@"收益概览", nil);
    UIImage *select2 = [UIImage imageNamed:@"home2"];
    profNav.tabBarItem.image = select2;
    
    MineController *mine = [MineController new];
    YiCaiNavigationController *mineNav = [[YiCaiNavigationController alloc] initWithRootViewController:mine];
    mineNav.tabBarItem.title = NSLocalizedString(@"我的", nil);
    UIImage *select3 = [UIImage imageNamed:@"my2"];
    mineNav.tabBarItem.image = select3;
    
    
    
    [self addChildViewController:orderNav];
    [self addChildViewController:profNav];
    [self addChildViewController:mineNav];
    self.selectedIndex = 1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
