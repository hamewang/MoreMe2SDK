//
//  MoreOpenImage.h
//  DJM
//
//  Created by 曾凌坤 on 2019/6/15.
//  Copyright © 2019 DJBeauty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreOpenImage : NSObject

/**
 获取网络图片  需要本地图片上传到服务器经过算法处理才能生成
 
 @param imagePath 图片路径
 */
+ (void)downloadImageByPath:(NSString *)imagePath  process:(void(^)(CGFloat progress,UIImage *image))success ;


/**
 获取检测报告数据信息
 
 @param param 请求参数  包含 cgid
 cid 字符串类型
 
 @param success 成功回调
 */
+ (void)queryImageInfoByPaht:(NSDictionary *)param process:(void(^)(NSDictionary *info))success failure:(void(^)(NSError *error))failed;


/**
 返回病症描述
 
 @param param 请求参数： language 语言版本 字符串类型
 cgid 案例组  字符串类型
 */
+ (void)queryAISkinDescriptionByParam:(NSDictionary *)param  info:(void(^)(NSDictionary *info))success failure:(void(^)(NSError *error))failed;

@end

NS_ASSUME_NONNULL_END
