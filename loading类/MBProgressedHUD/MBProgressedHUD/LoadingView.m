//
//  LoadingView.m
//  MBProgressedHUD
//
//  Created by Gguomingyue on 2018/5/17.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (id)init {
    return [self initWithFrame:CGRectMake(10.f, 10.f, 37.f, 37.f)];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        _progressTintColor = [[UIColor alloc] initWithWhite:1.f alpha:1.f];
        _backgroundTintColor = [[UIColor alloc] initWithWhite:1.f alpha:.1f];
    }
    return self;
}

-(void)setProgress:(float)progress
{
    if (progress != _progress) {
        _progress = progress;
        [self setNeedsDisplay];
    }
}

-(void)setProgressTintColor:(UIColor *)progressTintColor
{
    if (progressTintColor != _progressTintColor && ![progressTintColor isEqual:_progressTintColor]) {
        _progressTintColor = progressTintColor;
        [self setNeedsDisplay];
    }
}

- (void)setBackgroundTintColor:(UIColor *)backgroundTintColor {
    if (backgroundTintColor != _backgroundTintColor && ![backgroundTintColor isEqual:_backgroundTintColor]) {
        _backgroundTintColor = backgroundTintColor;
        [self setNeedsDisplay];
    }
}


-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat lineWidth = 2.0f;
    CGRect allRect = self.bounds;
    CGRect circleRect = CGRectInset(allRect, lineWidth/2.f, lineWidth/2.f);
    CGPoint center = CGPointMake(CGRectGetMidX(allRect), CGRectGetMidY(allRect));
    [self.progressTintColor setStroke];
    [self.backgroundTintColor setFill];
    //[self.progressTintColor setFill];
    CGContextSetLineWidth(context, lineWidth);
    CGContextStrokeEllipseInRect(context, circleRect);
    //CGContextFillEllipseInRect(context, circleRect);
    CGFloat startAngle = -M_PI/2.0f;
    CGFloat endAngle = self.progress * 2.0f * M_PI + startAngle;
    CGFloat radius = CGRectGetWidth(self.bounds)/2.0f - lineWidth;
    [self.progressTintColor setFill];
    
    /*
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
     */
    
    UIBezierPath *progressPath = [UIBezierPath bezierPath];
    progressPath.lineCapStyle = kCGLineCapButt;
    progressPath.lineWidth = lineWidth * 2.0f;
    CGFloat radiusOther = (CGRectGetWidth(self.bounds) / 2.f) - (progressPath.lineWidth / 2.f);
    [progressPath addArcWithCenter:center radius:radiusOther startAngle:startAngle endAngle:endAngle clockwise:YES];
    // Ensure that we don't get color overlapping when _progressTintColor alpha < 1.f.
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    [self.progressTintColor set];
    [progressPath stroke];
}

@end
