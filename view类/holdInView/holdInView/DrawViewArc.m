//
//  DrawViewArc.m
//  holdInView
//
//  Created by Gguomingyue on 2019/12/25.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "DrawViewArc.h"
 
@implementation DrawViewArc
 
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}
 
- (void)drawRect:(CGRect)rect {
    //中间镂空的矩形框
    CGRect myRect =CGRectMake(100,100,200, 200);
 
    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    //镂空
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:myRect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
 
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor whiteColor].CGColor;
    fillLayer.opacity = 0.5;
    [self.layer addSublayer:fillLayer];
 
}

@end
