//
//  MYActivityIndicator.m
//  MBProgressedHUD
//
//  Created by Gguomingyue on 2018/5/17.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import "MYActivityIndicator.h"

@implementation MYActivityIndicator

+(instancetype)sharedInstance
{
    static MYActivityIndicator *indicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicator = [[MYActivityIndicator alloc] init];
    });
    return indicator;
}

-(void)addToShowView:(UIView *)showView
{
    self.showView = showView;
    [self.showView addSubview:self.activityIndicator];
    //self.activityIndicator = [[MBProgressHUD alloc] initWithView:showView];
    
    //self.activityIndicator.color = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 53, 53)];
    imageView.image = [UIImage imageNamed:@"bluecoloricon.png"];
    
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = @(0);
    animation.toValue = @(2*M_PI);
    animation.duration = 1.f;
    animation.repeatCount = INFINITY;
    animation.removedOnCompletion = NO;
    animation.timingFunction = linearCurve;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    UIImageView *cusView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 53, 53)];
    cusView.image = [UIImage imageNamed:@"bluecolor.png"];
    [cusView.layer addAnimation:animation forKey:@"keyFrameAnimation"];
    [imageView addSubview:cusView];
    
    self.activityIndicator.mode = MBProgressHUDModeCustomView;
    self.activityIndicator.customView = imageView;
    self.activityIndicator.square = YES;
    self.activityIndicator.labelText = @"上传中";
    self.activityIndicator.detailsLabelText = @"请耐心等待";
    self.activityIndicator.margin = 60.0f;
    [self.activityIndicator show:YES];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.activityIndicator.labelText = [NSString stringWithFormat:@"上传中（%d%%）",(int)(progress * 100)];
            });
            usleep(50000);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator hide:YES];
        });
    });
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self.activityIndicator hide:YES];
    //    });
}

-(MBProgressHUD *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[MBProgressHUD alloc] initWithView:self.showView];
    }
    return _activityIndicator;
}

-(void)setLabelText:(NSString *)labelText
{
    if (![_labelText isEqualToString:labelText]) {
        _labelText = labelText;
        self.activityIndicator.labelText = _labelText;
    }
}

-(void)setDetailLabelText:(NSString *)detailLabelText
{
    if (![_detailLabelText isEqualToString:detailLabelText]) {
        _detailLabelText = detailLabelText;
        self.activityIndicator.detailsLabelText = _detailLabelText;
    }
}

-(void)setProgress:(float)progress
{
    if (_progress != progress) {
        _progress = progress;
    }
}

@end
