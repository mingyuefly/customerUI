//
//  GMLayoutRate.h
//  GmLoanClient
//
//  Created by Gguomingyue on 16/7/13.
//  Copyright © 2016年 Gguomingyue. All rights reserved.
//

#ifndef GMLayoutRate_h
#define GMLayoutRate_h

#include <stdio.h>
float layoutRateByHeight(float orginLayout);
float layoutRateByHeightForPlus(float orginLayout);
#endif /* GMLayoutRate_h */

#import <UIKit/UIKit.h>
@interface GMLayoutRate :NSObject
+ (CGFloat)layoutRateByOCHeight:(CGFloat)orginLayout;
+ (CGFloat)layoutRateByOCHeightForPlus:(CGFloat)orginLayout;
@end
