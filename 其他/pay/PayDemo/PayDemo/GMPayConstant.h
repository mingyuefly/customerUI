//
//  GMPayConstant.h
//  PayDemo
//
//  Created by Gguomingyue on 2018/3/28.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GM_WxUrlSign @"weixin"
#define GM_WxUrlPrefix   [NSString stringWithFormat:@"%@%@",GM_WxUrlSign,@"://"]

#define GM_AlUrlSign @"alipay"
#define GM_AlUrlPrefix  [NSString stringWithFormat:@"%@%@",GM_AlUrlSign,@"://"]
#define GM_AlUrlClient  [NSString stringWithFormat:@"%@%@",GM_AlUrlSign,@"client/?"]

@interface GMPayConstant : NSObject

@end
