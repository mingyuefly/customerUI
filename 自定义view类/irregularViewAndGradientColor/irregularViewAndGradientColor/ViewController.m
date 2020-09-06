//
//  ViewController.m
//  irregularViewAndGradientColor
//
//  Created by mingyue on 2020/9/5.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *gradientView;
@property (nonatomic, strong) UIImageView *linearImageView;
@property (nonatomic, strong) UIImageView *radialImageView;
@property (nonatomic, strong) UIImageView *firstCircle;
@property (nonatomic, strong) CAShapeLayer *firstCircleShapeLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.gradientView];
    [self.view addSubview:self.linearImageView];
    [self.view addSubview:self.radialImageView];
    
    // 1.CAGradientLayer实现渐变
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.gradientView.bounds;
    [self.gradientView.layer addSublayer:gradientLayer];
    
    // 2.Core Graphics相关方法实现渐变
    [self drawLinearGradient];
    [self drawRadialGradient];
    
    // 3.以CAShapeLayer作为layer的mask属性
    /*
    1、生成一个imageView(也可以为layer)，image的属性为颜色渐变的图片
    2、生成一个CAShapeLayer对象，根据path属性指定所需的形状
    3、将CAShapeLayer对象赋值给imageView的mask属性
     */
    [self.view addSubview:self.firstCircle];
    self.firstCircle.frame = CGRectMake(100, 480, 150, 150);
    CGFloat firsCircleWidth = 5;
    self.firstCircleShapeLayer = [self generateShapeLayerWithLineWidth:firsCircleWidth];
    self.firstCircleShapeLayer.path = [self generateBezierPathWithCenter:CGPointMake(75, 75) radius:75].CGPath;
    self.firstCircle.layer.mask = _firstCircleShapeLayer;
}

#pragma mark - linear gradient
-(void)drawLinearGradient
{
    UIGraphicsBeginImageContext(CGSizeMake(300, 120));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rect = CGRectMake(0, 0, 300, 120);
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPathCloseSubpath(path);
    
    int n = 2;
    CGFloat *locations = (CGFloat *)malloc(n * sizeof(CGFloat));
    locations[0] = 0.0;
    locations[1] = 1.0;
    CGColorRef startColor = [UIColor greenColor].CGColor;
    CGColorRef endColor = [UIColor redColor].CGColor;
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    [self drawLinerGradient:context path:path location:locations colors:(__bridge CFArrayRef)(colors)];
    CGPathRelease(path);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.linearImageView.image = image;
}

-(void)drawLinerGradient:(CGContextRef)context path:(CGPathRef)path location:(CGFloat *)locations colors:(CFArrayRef)colors
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    free(locations);
    locations = NULL;
}

#pragma mark - radial gradient
-(void)drawRadialGradient
{
    UIGraphicsBeginImageContext(CGSizeMake(300, 200));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rect = CGRectMake(0, 0, 300, 200);
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPathCloseSubpath(path);
    
    int n = 2;
    CGFloat *locations = (CGFloat *)malloc(n * sizeof(CGFloat));
    locations[0] = 0.0;
    locations[1] = 1.0;
    CGColorRef startColor = [UIColor greenColor].CGColor;
    CGColorRef endColor = [UIColor redColor].CGColor;
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    [self drawRadialGradient:context path:path location:locations colors:(__bridge CFArrayRef)(colors)];
    CGPathRelease(path);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.radialImageView.image = image;
}

-(void)drawRadialGradient:(CGContextRef)context path:(CGPathRef)path location:(CGFloat *)locations colors:(CFArrayRef)colors
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
    CGFloat radius = MAX(pathRect.size.width/2, pathRect.size.height/2) * sqrt(2);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    CGContextDrawRadialGradient(context, gradient, centerPoint, 0, centerPoint, radius, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    free(locations);
    locations = NULL;
}

#pragma mark - 以CAShapeLayer作为layer的mask属性
- (CAShapeLayer *)generateShapeLayerWithLineWidth:(CGFloat)lineWidth
{
    CAShapeLayer *waveline = [CAShapeLayer layer];
    waveline.lineCap = kCALineCapButt;
    waveline.lineJoin = kCALineJoinRound;
    waveline.strokeColor = [UIColor redColor].CGColor;
    waveline.fillColor = [[UIColor clearColor] CGColor];
    waveline.lineWidth = lineWidth;
    waveline.backgroundColor = [UIColor clearColor].CGColor;
    
    return waveline;
}

- (UIBezierPath *)generateBezierPathWithCenter:(CGPoint)center radius:(CGFloat)radius
{
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:NO];
    
    return circlePath;
}

#pragma mark - property
-(UIView *)gradientView
{
    if (!_gradientView) {
        _gradientView = [[UIView alloc] initWithFrame:CGRectMake(20, 50, 300, 50)];
        _gradientView.backgroundColor = [UIColor clearColor];
    }
    return _gradientView;
}

-(UIImageView *)linearImageView
{
    if (!_linearImageView) {
        _linearImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, 300, 120)];
        _linearImageView.backgroundColor = [UIColor blueColor];
    }
    return _linearImageView;
}

-(UIImageView *)radialImageView
{
    if (!_radialImageView) {
        _radialImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 260, 300, 200)];
        _radialImageView.backgroundColor = [UIColor blueColor];
    }
    return _radialImageView;
}

- (UIImageView *)firstCircle
{
    if (!_firstCircle) {
        _firstCircle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circleBackground"]];
        _firstCircle.layer.masksToBounds = YES;
        _firstCircle.alpha = 1.0;
    }
    return _firstCircle;
}

@end
