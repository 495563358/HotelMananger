//
//  AboutUSController.m
//  HotelManager
//
//  Created by oops on 2019/6/20.
//  Copyright © 2019 oops. All rights reserved.
//

#import "AboutUSController.h"
#import "AppDelegate.h"

@interface AboutUSController ()

@end

@implementation AboutUSController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = color(88, 188, 98, 1);
    // Do any additional setup after loading the view.
    [self loaddata];
}

-(void)loaddata{
    UserModel *model = [(AppDelegate *)[UIApplication sharedApplication].delegate userModel];
    NSString *projectId = model.projectId;
    NSDictionary *param = @{@"projectId":projectId,@"appType":@"IOS"};
    [BaseocHttpService postRequest:[baseAddress stringByAppendingString:getAppVersionByProjectId] andParagram:param rightBlock:^(id responseObject) {
        [self createUI:responseObject];
    } errorBlock:^(id responseObject) {
        [DCSpeedy showToastWithText:@"获取信息失败,请联系客服"];
    }];
}

-(void)createUI:(NSDictionary *)resp{
    
    
    UIView *whiteB = [[UIView alloc] initWithFrame:CGRectMake(10, SafeAreaTopHeight + 10, ScreenWidth - 20, 200)];
    whiteB.backgroundColor = [UIColor whiteColor];
    [whiteB setCornerRadius:8];
    
    
    NSArray *names = @[@"版本号",@"网址",@"卡西朵",@"客服电话"];
    NSArray *descArr = @[resp[@"verNo"],resp[@"downloadPath"],resp[@"appWeixin"],resp[@"appTel"]];
    
    for (int i = 0; i<4; i++) {
        UILabel *lab1 = [UILabel labelWithText:names[i] fontSize:15 frame:CGRectMake(10, 50*i, 200, 50) color:[UIColor blackColor] textAlignment:0];
        
        UILabel *lab2 = [UILabel labelWithText:[NSString stringWithFormat:@"%@",descArr[i]] fontSize:14 frame:CGRectMake(ScreenWidth - 200, 50*i, 170, 50) color:[UIColor grayColor] textAlignment:2];
        [whiteB addSubview:lab1];
        [whiteB addSubview:lab2];
        lab2.tag = i;
        if (i != 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 50*i, whiteB.width - 20, 1)];
            line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [whiteB addSubview:line];
        }
        lab2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [lab2 addGestureRecognizer:tap];
    }
    
    [self.view addSubview:whiteB];
}

-(void)tapClick:(UITapGestureRecognizer *)tap{
    UILabel *lab = (UILabel *)tap.view;
    if (lab.tag == 1) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = lab.text;
        [SVProgressHUD showSuccessWithStatus:@"已复制到剪切板"];
        [SVProgressHUD dismissWithDelay:1.5];
    }else if (lab.tag == 2){
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = lab.text;
        [SVProgressHUD showSuccessWithStatus:@"已复制到剪切板"];
        [SVProgressHUD dismissWithDelay:1.5];
        
    }else if (lab.tag == 3){
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4006812010"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }

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
