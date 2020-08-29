//
//  RequestAddress.h
//  bychat
//
//  Created by 胡彬 on 2018/7/10.
//  Copyright © 2018年 defu. All rights reserved.
//

#ifndef RequestAddress_h
#define RequestAddress_h

#define baseAddress                         @"http://47.99.202.76:8080/kaxiduo/app/"

//登陆
#define req_login_logon                     @"login"

//获取收益列表
#define getOrderPageByCondition             @"getOrderPageList"

//获取收益详情
#define getOrderInfoById                    @"getOrderDetailById"

//获取收益，根据时间区间
#define getIncomeByCondition                @"getIncomeByCondition"

//首页界面
#define getDateByCondition                  @"getDateByCondition"

//修改密码
#define req_change_pwd                      @"update"

//版本信息
#define getAppVersionByProjectId            @"getAppVersionByProjectId"

//商务经理
#define getBussinessByProjectId             @"getBussinessByProjectId"

//获取刷新token
#define user_user_refresh                   @"user/user/refresh"
//退出登录
#define Exit_login                          @"login/logout"
//注册
#define User_Regist                         @"login/user_register"
//试玩
#define get_demo_account                    @"login/get_demo_account"



#endif /* RequestAddress_h */
