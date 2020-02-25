//
//  GMPayManager.h
//  PayDemo
//
//  Created by Gguomingyue on 2018/3/27.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PayType){
    UnionPay     = 0,
    AliPay       = 1,
    WXPay        = 2,
};

@interface GMPayWXModel : NSObject

/** 微信开放平台审核通过的应用APPID*/
@property (nonatomic, copy) NSString* openID;
/** 微信支付分配的商户号 */
@property (nonatomic, copy) NSString *partnerId;
/** 微信返回的支付交易会话ID */
@property (nonatomic, copy) NSString *prepayId;
/** 随机串，防重发 */
@property (nonatomic, copy) NSString *nonceStr;
/** 时间戳，防重发 */
@property (nonatomic, assign) UInt32 timeStamp;
/** 扩展字段,暂填写固定值Sign=WXPay */
@property (nonatomic, copy) NSString *package;
/** 签名 */
@property (nonatomic, copy) NSString *sign;

@end

@interface GMPayManager : NSObject

+(instancetype)shareManager;
-(BOOL)wxAppInstalled;
-(BOOL)aliPayInstalled;
-(void)wxpayOrder:(GMPayWXModel *)model
        completed:(void (^)(NSDictionary *resultDictionary))completedBlock;
-(void)alipayOrder:(NSString *)orderStr
        fromScheme:(NSString *)schemeStr
         completed:(void(^)(NSDictionary *resultDict))completedBlock;
-(void)unionPayOrder:(NSString*)tn
      viewController:(UIViewController*)viewController;
-(BOOL)handleOpenURL:(NSURL *)url;

@end
