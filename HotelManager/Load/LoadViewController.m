//
//  LoadViewController.m
//  HotelManager
//
//  Created by oops on 2019/6/18.
//  Copyright © 2019 oops. All rights reserved.
//

#import "LoadViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LoadViewController()

@property(nonatomic,strong)UITextField *accountT;
@property(nonatomic,strong)UITextField *passwordT;
@property(nonatomic,strong)UIButton *loadBtn;
@property(nonatomic,strong)UIButton *rememberPwd;

@end

@implementation LoadViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self createUI];
}

-(void)createUI{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 318*ScreenWidth/634)];
    imageV.image = [UIImage imageNamed:@"load"];
    [self.view addSubview:imageV];
    
    CGFloat hh = imageV.height + 60;
    
    UIImageView *leftV1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account"]];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(40, hh+40, ScreenWidth - 80, 1)];
    line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.accountT = [[UITextField alloc]initWithFrame:CGRectMake(40, hh, ScreenWidth - 80, 40)];
    _accountT.placeholder = @"  请输入账号";
    _accountT.borderStyle = UITextBorderStyleNone;
    _accountT.leftView = leftV1;
    _accountT.leftViewMode = UITextFieldViewModeAlways;
    [_accountT setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
    _accountT.keyboardType = UIKeyboardTypeNumberPad;
    
    
    hh += 60;
    UIImageView *leftV2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(40, hh+40, ScreenWidth - 80, 1)];
    line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.passwordT = [[UITextField alloc]initWithFrame:CGRectMake(40, hh, ScreenWidth - 80, 40)];
    _passwordT.placeholder = @"  请输入密码";
    _passwordT.borderStyle = UITextBorderStyleNone;
    _passwordT.leftView = leftV2;
    _passwordT.leftViewMode = UITextFieldViewModeAlways;
    [_passwordT setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
    _passwordT.secureTextEntry = YES;
    
    self.rememberPwd = [UIButton new];
    _rememberPwd.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rememberPwd setTitle:@"记住密码" forState:UIControlStateNormal];
    [_rememberPwd setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_rememberPwd setImage:[UIImage imageNamed:@"check_normal"] forState:UIControlStateNormal];
    [_rememberPwd setImage:[UIImage imageNamed:@"check_selected"] forState:UIControlStateSelected];
    [_rememberPwd layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [_rememberPwd addTarget:self action:@selector(rememberPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    _passwordT.rightView = self.rememberPwd;
    _passwordT.rightViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:_accountT];
    [self.view addSubview:line1];
    [self.view addSubview:_passwordT];
    [self.view addSubview:line2];
    
    hh += 70;
    self.loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, hh, ScreenWidth - 80, 40)];
    [_loadBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loadBtn.backgroundColor = color(133, 219, 69, 1);
    [_loadBtn setCornerRadius:5];
    [_loadBtn addTarget:self action:@selector(loadClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loadBtn];
    
    hh += 60;
    UIButton *forget = [UIButton buttonWithLocalImage:nil title:@"忘记密码" titleColor:[UIColor blackColor] fontSize:15 frame:CGRectMake(40, hh, ScreenWidth - 80, 40)];
    [forget addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forget];
    
//    _accountT.text = @"17610602092";
    
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    if (account && account.length) {
        _accountT.text = account;
        _passwordT.text = [[NSUserDefaults standardUserDefaults] objectForKey:account];
        if (_passwordT.text.length) {
            self.rememberPwd.selected = YES;
        }
    }
}

-(void)rememberPasswordAction:(UIButton *)sender{
    sender.selected = !sender.isSelected;
}

-(void)loadClick{
    [self.view endEditing:YES];
    NSString *account = _accountT.text;
    NSString *password = _passwordT.text;
    if (password.length < 1) {
        [DCSpeedy showToastWithText:@"请检查您的账号密码后重试"];
        return;
    }
    NSString *pwdMD5 = [ObjectTools md532BitLower:password];
    //17610602092
//    pwdMD5 = [ObjectTools md532BitLower:@"123456qwe78"];
    MJWeakSelf
    NSDictionary *param = @{@"ownerPhone":account,@"ownerPwd":pwdMD5};
    NSLog(@"%@",param);
    [BaseocHttpService postRequest:[baseAddress stringByAppendingString:req_login_logon] andParagram:param rightBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        UserModel *model = [UserModel modelWithDictionary:responseObject];
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        dele.userModel = model;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LOADSUCCESS" object:nil];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:account forKey:@"account"];
        if (weakSelf.rememberPwd.isSelected) {
            [user setObject:password forKey:account];
        }else{
            [user setObject:@"" forKey:account];
        }
        [user synchronize];
    } errorBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [DCSpeedy showToastWithText:responseObject[@"resultDesc"]];
    }];
}

-(void)forgetPassword{
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"https://upload.yicaiapi.com/uploads/1/d6081c53062a45cb18cc0fb9db3ebbe7.wav"]];
    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:item];
    
    [player play];
}

@end
