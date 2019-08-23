//
//  MoreMeCammer.h
//  DJM
//
//  Created by 曾凌坤 on 2019/6/17.
//  Copyright © 2019 DJBeauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreMeCammer : NSObject

/**
 init sdk

 @param appId 后台注册获取  必填
 @param skey 后台注册获取  必填
 @param cipher 后台注册获取  必填
 */
+ (void)startWithAppId:(NSString *)appId skey:(NSString *)skey  cipher:(NSString *)cipher;
@end

NS_ASSUME_NONNULL_END
