//
//  AppDelegate.m
//  HotelManager
//
//  Created by oops on 2019/6/17.
//  Copyright © 2019 oops. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadViewController.h"
#import "YiCaiTabBarController.h"
#import <AvoidCrash.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 配置防闪退
    [self configAvoidCrash];
    [self setRootTextAttributes];
    //根视图
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    LoadViewController *launch = [LoadViewController new];
    self.window.rootViewController = launch;
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"LOADSUCCESS" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        //登录成功 重新给mainWindow
        YiCaiTabBarController *tabBar = [[YiCaiTabBarController alloc] init];
        self.window.rootViewController = tabBar;
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"EXITSUCCESS" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        //登录成功 重新给mainWindow
        LoadViewController *launch = [LoadViewController new];
        self.window.rootViewController = launch;
    }];
    
    
    return YES;
}

#pragma mark - 防闪退
- (void)configAvoidCrash {
    [AvoidCrash makeAllEffective];
    NSArray *noneSelClassStrings = @[
                                     @"NSNull",
                                     @"NSNumber",
                                     @"NSString",
                                     @"NSDictionary",
                                     @"NSArray"
                                     ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
}

-(void)setRootTextAttributes
{
    [UINavigationBar appearance].barTintColor = color(34.4, 160, 64, 1);//color(69, 175, 94, 1);
    //    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:SystemColor] forBarPosition:3 barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary  dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    //tabbar 字体大小及选中和未选中颜色设置
//
//    NSMutableDictionary *attr4=[NSMutableDictionary dictionary];
//    attr4[NSForegroundColorAttributeName]=color(88, 188, 98, 1);
//    attr4[NSFontAttributeName]=[UIFont systemFontOfSize:13];
//    [[UITabBarItem appearance]setTitleTextAttributes:attr4 forState:UIControlStateSelected];
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
