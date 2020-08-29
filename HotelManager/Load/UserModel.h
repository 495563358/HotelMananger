//
//  UserModel.h
//  HotelManager
//
//  Created by oops on 2019/6/18.
//  Copyright © 2019 oops. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic,copy)NSString *createBy;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *hourseCount;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *ownerAddr;
@property (nonatomic,copy)NSString *ownerEmail;
@property (nonatomic,copy)NSString *ownerName;
@property (nonatomic,copy)NSString *ownerPwd;
@property (nonatomic,copy)NSString *ownerTel;
@property (nonatomic,copy)NSString *projectId;
@property (nonatomic,copy)NSString *projectName;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *token;

@end

NS_ASSUME_NONNULL_END
