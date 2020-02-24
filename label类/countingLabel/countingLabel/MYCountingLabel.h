//
//  MYCountingLabel.h
//  countingLabel
//
//  Created by Gguomingyue on 2019/11/7.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYCountingLabel : UILabel

-(void)countFrom:(CGFloat)fromValue to:(CGFloat)toValue;
-(void)countFrom:(CGFloat)fromValue to:(CGFloat)toValue duration:(CGFloat)duration;
-(void)countTo:(CGFloat)toValue;
-(void)countRandomTo:(CGFloat)toValue;
-(void)countTo:(CGFloat)toValue duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
