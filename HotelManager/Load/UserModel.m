//
//  UserModel.m
//  HotelManager
//
//  Created by oops on 2019/6/18.
//  Copyright © 2019 oops. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+(instancetype)modelWithDictionary:(NSDictionary *)dict{
    UserModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [super setValue:value forKey:@"ID"];
    }else{
        [super setValue:value forKey:key];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
