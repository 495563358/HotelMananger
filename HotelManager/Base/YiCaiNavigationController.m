//
//  YiCaiNavigationController.m
//  yicai
//
//  Created by oops on 2018/12/29.
//  Copyright © 2018 defuya. All rights reserved.
//

#import "YiCaiNavigationController.h"
#import "ObjectTools.h"

@interface YiCaiNavigationController()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property(nonatomic, weak) UIViewController *currentShowVC;

@end

@implementation YiCaiNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    YiCaiNavigationController *nav = [super initWithRootViewController:rootViewController];
    nav.interactivePopGestureRecognizer.delegate = self;
    nav.delegate = self;
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (1 == navigationController.viewControllers.count) {
        self.currentShowVC = nil;
    } else {
        self.currentShowVC = viewController;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 判断是否是根控制器 非根控制器才需要设置返回按钮
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [self createChildControllerBackButton];
        if (self.childViewControllers.count == 1) {
            viewController.hidesBottomBarWhenPushed = YES;
            [super pushViewController:viewController animated:animated];
            viewController.hidesBottomBarWhenPushed = NO;
        }else{
            viewController.hidesBottomBarWhenPushed = YES;
            [super pushViewController:viewController animated:animated];
        }
    }else{
        [super pushViewController:viewController animated:animated];
    }
}

-(UIBarButtonItem *)createChildControllerBackButton{
    // 设置返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"white_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"white_back"] forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    // 注意:一定要在按钮内容有尺寸的时候,设置才有效果
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return barbutton;
}

-(void)back{
    [super popViewControllerAnimated:YES];
}

@end
