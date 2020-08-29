//
//  ChangePwdController.m
//  HotelManager
//
//  Created by oops on 2019/6/20.
//  Copyright © 2019 oops. All rights reserved.
//

#import "ChangePwdController.h"

@interface ChangePwdController ()

@property(nonatomic,strong)UITextField *regist1;
@property(nonatomic,strong)UITextField *regist2;
@property(nonatomic,strong)UITextField *regist3;

@end

@implementation ChangePwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat height = 65;
    UILabel *label1 = [UILabel labelWithText:@"         旧密码" fontSize:16 frame:CGRectMake(0, 0, 120, 40) color:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    UILabel *label2 = [UILabel labelWithText:@"         新密码" fontSize:16 frame:CGRectMake(0, 0, 120, 40) color:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    UILabel *label3 = [UILabel labelWithText:@"         确认新密码" fontSize:16 frame:CGRectMake(0, 0, 120, 40) color:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    
    UIView *left1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    [left1 addSubview:label1];
    UIView *left2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    [left2 addSubview:label2];
    UIView *left3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    [left3 addSubview:label3];
    
    _regist1 = [[UITextField alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 20 + height, ScreenWidth, 45)];
    _regist1.placeholder = @"请填写旧密码";
    _regist1.leftView = left1;
    _regist1.leftViewMode = UITextFieldViewModeAlways;
    
    _regist2 = [[UITextField alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 20 + height*2, ScreenWidth, 45)];
    _regist2.placeholder = @"请输入新密码";
    _regist2.leftView = left2;
    _regist2.leftViewMode = UITextFieldViewModeAlways;
    
    _regist3 = [[UITextField alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 20 + height*3, ScreenWidth, 45)];
    _regist3.placeholder = @"请再次确认密码";
    _regist3.leftView = left3;
    _regist3.leftViewMode = UITextFieldViewModeAlways;
    
    for (int i = 0; i<3; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(35, SafeAreaTopHeight + 130 + height*i, ScreenWidth-70, 0.5)];
        line.backgroundColor = [UIColor grayColor];
        [self.view addSubview:line];
    }
    
    [self.view addSubview:_regist1];
    [self.view addSubview:_regist2];
    [self.view addSubview:_regist3];
    
//    _regist2.backgroundColor = _regist3.backgroundColor = [UIColor whiteColor];
    UILabel *labeldesc = [UILabel labelWithText:@"*密码至少8个字符,而且同时包含数字和字母。" fontSize:15 frame:CGRectMake(40, _regist3.y + 60, ScreenWidth - 80, 60) color:[UIColor blackColor] textAlignment:1];
    [self.view addSubview:labeldesc];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(40,  _regist3.y + 90 + 40, ScreenWidth - 80, 50)];
    btn.backgroundColor = color(88, 188, 98, 1);
    [btn setCornerRadius:25];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)changePassword{
    NSString *oldPwd = _regist1.text;
    NSString *new_pwd = _regist2.text;
    NSString *verification = _regist3.text;
    
    if (oldPwd.length && new_pwd.length >= 8 && [new_pwd isEqualToString:verification]) {
        NSString *new_pwd_md5 = [ObjectTools md532BitLower:verification];
        NSString *old_pwd_md5 = [ObjectTools md532BitLower:oldPwd];
        NSDictionary *parma = @{@"ownerPwd":new_pwd_md5,@"oldPwd":old_pwd_md5};
        NSLog(@"提交修改");
        [BaseocHttpService postRequest:[baseAddress stringByAppendingString:req_change_pwd] andParagram:parma rightBlock:^(id responseObject) {
            NSLog(@"resp = %@",responseObject);
            [SVProgressHUD showSuccessWithStatus:@"修改成功,请使用新密码登录"];
            [SVProgressHUD dismissWithDelay:1.5];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EXITSUCCESS" object:nil];
        } errorBlock:^(id responseObject) {
            //返回错误代码
            NSLog(@"resp = %@",responseObject);
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                [SVProgressHUD showErrorWithStatus:responseObject[@"resultDesc"]];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"请检查您的密码后重试"];
        [SVProgressHUD dismissWithDelay:1.5];
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
