//
//  MoreCameraVC.h
//  DJM
//
//  Created by 曾凌坤 on 2019/6/4.
//  Copyright © 2019 DJBeauty. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kMultiLangString(str) NSLocalizedString(str, nil)
NS_ASSUME_NONNULL_BEGIN
/**
 拍照成功的回调
 
 @param images 字典数组包含图片信息（name:图片url,image:原图，imageType:当前图片类型）图片类型：ai 需要服务器生成 、local 本地生成的直接用image  info拍照信息，用于请求检测报告
 */
typedef void(^imageBlock)(NSArray *images,NSDictionary *info);//成功的回调

typedef void(^failyBlock)(id response);//失败的回调

@interface MoreCameraVC : UIViewController

//@param saveBlock 成功的回调  最少6张图片  最多15张图片的信息
//@param sessionBlock 失败的回调（包含各种权限判断

@property (nonatomic,copy)imageBlock saveBlock;
@property (nonatomic,copy)failyBlock sessionBlock;

/**
 进入拍照页面  的回调

 @param customer_id 顾客ID  必传
 @param shop_id 商店ID 必传
 @param name 顾客名字 选填
 @return 页面本身
 */
- (instancetype)initWithCustomerID:(NSString *)customer_id  shopID:(NSString *)shop_id customerName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
