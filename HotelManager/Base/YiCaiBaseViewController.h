//
//  YiCaiBaseViewController.h
//  yicai
//
//  Created by defuya on 2018/11/26.
//  Copyright © 2018年 defuya. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YiCaiBaseViewController : UIViewController

@property (nonatomic,copy)NSArray *requestData;
@property (nonatomic,assign)BOOL needViewOffset;

@end

NS_ASSUME_NONNULL_END
