//
//  DrawView.m
//  holdInView
//
//  Created by Gguomingyue on 2019/12/25.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView
 
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置 背景为clear
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}
 
- (void)drawRect:(CGRect)rect {
 
    [[UIColor colorWithWhite:0 alpha:0.5] setFill];
    //半透明区域
    UIRectFill(rect);
 
    //透明的区域
    CGRect holeRection = CGRectMake(100, 200, 200, 200);
    /** union: 并集
     CGRect CGRectUnion(CGRect r1, CGRect r2)
     返回并集部分rect
     */
 
    /** Intersection: 交集
     CGRect CGRectIntersection(CGRect r1, CGRect r2)
     返回交集部分rect
     */
    CGRect holeiInterSection = CGRectIntersection(holeRection, rect);
    [[UIColor clearColor] setFill];
 
    //CGContextClearRect(ctx, <#CGRect rect#>)
    //绘制
    //CGContextDrawPath(ctx, kCGPathFillStroke);
    UIRectFill(holeiInterSection);
}



@end
