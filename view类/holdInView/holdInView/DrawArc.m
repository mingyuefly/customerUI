//
//  DrawArc.m
//  holdInView
//
//  Created by Gguomingyue on 2019/12/25.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "DrawArc.h"
 
@implementation DrawArc
 
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
 
    CGContextRef ctx = UIGraphicsGetCurrentContext();
 
    //背景色
    //[[UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]] set];
    [[UIColor colorWithWhite:0 alpha:0.5] set];
    CGContextAddRect(ctx, rect);
    CGContextFillPath(ctx);
 
    //设置清空模式
    /**
     kCGBlendModeClear,
     kCGBlendModeCopy,
     kCGBlendModeSourceIn,
     kCGBlendModeSourceOut,
     kCGBlendModeSourceAtop,
     kCGBlendModeDestinationOver,
     kCGBlendModeDestinationIn,
     kCGBlendModeDestinationOut,
     kCGBlendModeDestinationAtop,
     kCGBlendModeXOR,
     kCGBlendModePlusDarker,
     kCGBlendModePlusLighter
     */
    CGContextSetBlendMode(ctx, kCGBlendModeClear);
 
    //画圆
    CGContextAddEllipseInRect(ctx, myRect);
 
    //填充
    CGContextFillPath(ctx);
 
}

@end
