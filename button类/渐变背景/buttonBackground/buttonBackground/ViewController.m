//
//  ViewController.m
//  buttonBackground
//
//  Created by Gguomingyue on 2018/12/14.
//  Copyright © 2018 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CAGradientLayer *canLoginLayer;
@property (nonatomic, strong) CAGradientLayer *btnFinishedLayer;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) BOOL change;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [button setTitle:@"gradient" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    self.button = button;
    self.change = NO;
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor];
//    gradientLayer.locations = @[@0.0f, @1.0f];
//    gradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
//    gradientLayer.endPoint = CGPointMake(1.0f, 0.0f);
//    gradientLayer.frame = button.bounds;
    [button.layer insertSublayer:self.canLoginLayer atIndex:0];
    
    [self.view addSubview:button];
}

-(void)changeColor
{
    self.change = !self.change;
    CAGradientLayer *gradientLayer = [self.button.layer.sublayers objectAtIndex:0];
    [gradientLayer removeFromSuperlayer];
    if (self.change) {
        //gradientLayer = self.canLoginLayer;
        //[self.button.layer insertSublayer:self.btnFinishedLayer atIndex:1];
        //[self.button.layer insertSublayer:self.btnFinishedLayer above:self.canLoginLayer];
        [self.button.layer insertSublayer:self.btnFinishedLayer atIndex:0];
    } else {
        //[self.button.layer insertSublayer:self.canLoginLayer atIndex:1];
        //[self.button.layer insertSublayer:self.canLoginLayer above:self.btnFinishedLayer];
        //gradientLayer = self.btnFinishedLayer;
        [self.button.layer insertSublayer:self.canLoginLayer atIndex:0];
    }
    
    NSLog(@"self.button.layer.sublayers.count = %lu",self.button.layer.sublayers.count);
    for (CALayer *layer in self.button.layer.sublayers) {
        NSLog(@"layer = %@", layer);
    }
}

-(CAGradientLayer *)canLoginLayer
{
    if (!_canLoginLayer) {
        _canLoginLayer = [CAGradientLayer layer];
        UIColor *firstColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
        UIColor *secondColor = [[UIColor yellowColor] colorWithAlphaComponent:0.4];
        _canLoginLayer.colors = @[(__bridge id)firstColor.CGColor, (__bridge id)secondColor.CGColor];
        _canLoginLayer.locations = @[@0.0f, @1.0f];
        _canLoginLayer.startPoint = CGPointMake(0.0f, 0.0f);
        _canLoginLayer.endPoint = CGPointMake(1.0f, 0.0f);
        _canLoginLayer.frame = self.button.bounds;
    }
    return _canLoginLayer;
}

-(CAGradientLayer *)btnFinishedLayer
{
    if (!_btnFinishedLayer) {
        _btnFinishedLayer = [CAGradientLayer layer];
        _btnFinishedLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor];
        _btnFinishedLayer.locations = @[@0.0f, @1.0f];
        _btnFinishedLayer.startPoint = CGPointMake(0.0f, 0.0f);
        _btnFinishedLayer.endPoint = CGPointMake(1.0f, 0.0f);
        _btnFinishedLayer.frame = self.button.bounds;
    }
    return _btnFinishedLayer;
}



@end
