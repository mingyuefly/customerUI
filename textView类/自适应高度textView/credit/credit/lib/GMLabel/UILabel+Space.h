//
//  UILabel+Space.h
//  GLoanClient
//
//  Created by Gguomingyue on 2018/6/20.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Space)

-(void)setLineSpace:(CGFloat)space;
-(void)setwordSpace:(CGFloat)space;
-(void)setLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace;
//-(CGFloat)getHeightWithLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace;
//-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;

@end
