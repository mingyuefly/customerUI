//
//  ViewController.m
//  holdInView
//
//  Created by Gguomingyue on 2019/12/25.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "DrawViewRect.h"
#import "DrawViewArc.h"
#import "DrawArc.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) DrawView *drawView;
@property (nonatomic, strong) DrawViewRect *drawViewRect;
@property (nonatomic, strong) DrawViewArc *drawViewArc;
@property (nonatomic, strong) DrawArc *drawArc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    //[self.view addSubview:self.drawView];
    //[self.view addSubview:self.drawViewRect];
    //[self.view addSubview:self.drawViewArc];
    //[self.view addSubview:self.drawArc];
    [self addArc];
}

- (void)addArc {
    //中间镂空的矩形框
    CGRect myRect =CGRectMake(100,100,200, 200);
 
    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:[UIScreen mainScreen].bounds cornerRadius:0];
    //镂空
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:myRect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
 
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor whiteColor].CGColor;
    fillLayer.opacity = 0.5;
    [self.view.layer addSublayer:fillLayer];
 
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _imageView.image = [UIImage imageNamed:@"Image"];
    }
    return _imageView;
}

-(DrawView *)drawView
{
    if (!_drawView) {
        _drawView = [[DrawView alloc] initWithFrame:self.view.bounds];
    }
    return _drawView;
}

-(DrawViewRect *)drawViewRect
{
    if (!_drawViewRect) {
        _drawViewRect = [[DrawViewRect alloc] initWithFrame:self.view.bounds];
    }
    return _drawViewRect;
}

-(DrawViewArc *)drawViewArc
{
    if (!_drawViewArc) {
        _drawViewArc = [[DrawViewArc alloc] initWithFrame:self.view.bounds];
    }
    return _drawViewArc;
}

-(DrawArc *)drawArc
{
    if (!_drawArc) {
        _drawArc = [[DrawArc alloc] initWithFrame:self.view.bounds];
    }
    return _drawArc;
}

@end
