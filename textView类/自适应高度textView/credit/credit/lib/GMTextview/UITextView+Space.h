//
//  UITextView+Space.h
//  GLoanClient
//
//  Created by Gguomingyue on 2018/6/20.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Space)

-(void)setLineSpace:(CGFloat)space;
-(void)setLineSpace:(CGFloat)space Attributed:(NSMutableAttributedString *)attributeString Range:(NSRange)range;
-(void)setwordSpace:(CGFloat)space;
-(void)setLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace;

@end
