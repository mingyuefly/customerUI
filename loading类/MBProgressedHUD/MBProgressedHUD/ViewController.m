//
//  ViewController.m
//  MBProgressedHUD
//
//  Created by Gguomingyue on 2018/5/10.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "LoadingView.h"
#import "BackgroundView.h"
#import "MYActivityIndicator.h"

@interface ViewController ()

@property (nonatomic, strong) MBProgressHUD *hudView;
@property (nonatomic, strong) LoadingView *loadingView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) BackgroundView *backgroundView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.hudView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button setTitle:@"show" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(220, 100, 100, 30);
    [cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor redColor];
    [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    UIButton *loadinglButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loadinglButton.frame = CGRectMake(100, 150, 100, 30);
    [loadinglButton setTitle:@"loading" forState:UIControlStateNormal];
    loadinglButton.backgroundColor = [UIColor redColor];
    [loadinglButton addTarget:self action:@selector(loadingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadinglButton];
}

-(void)buttonAction
{
    NSLog(@"buttonAction");
    //    self.hudView.dimBackground = NO;
    //    self.hudView.labelText = @"加载中...";
    //    [self.hudView show:YES];
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    //    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    //    });
    
    //
    
//    self.hudView.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
//    self.hudView.mode = MBProgressHUDModeCustomView;
//    //self.hudView.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
//    self.hudView.labelText = @"上传中哈哈哈哈哈哈或或或或或或或";
//    self.hudView.detailsLabelText = @"请耐心等待";
//    self.hudView.margin = 60.0f;
//    //hud.xOffset = 30.f;
//    //hud.yOffset = 60.f;
//    [self.hudView show:YES];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.hudView hide:YES];
//    });
    
    //self.hudView = [[MBProgressHUD alloc] initWithView:self.view];
    //    [self.hudView show:YES];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self.hudView hide:YES];
    //    });
    
    
    MYActivityIndicator *myActivityIndicator = [MYActivityIndicator sharedInstance];
    [myActivityIndicator addToShowView:self.view];
    
    
    
}

-(void)cancelButtonAction
{
    NSLog(@"cancelButtonAction");
    //[self.hudView hide:YES];
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    //[MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

-(void)loadingButtonAction
{
    NSLog(@"loadingButtonAction");
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.loadingView];
    self.loadingView.progressTintColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.loadingView.progress = progress;
            });
            usleep(50000);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.containerView removeFromSuperview];
        });
    });
}

-(MBProgressHUD *)hudView
{
    if (!_hudView) {
        _hudView = [[MBProgressHUD alloc] initWithView:self.view];
        //_hudView.progress = 0.4;
    }
    return _hudView;
}

-(LoadingView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[LoadingView alloc] init];
    }
    return _loadingView;
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 57, 57)];
        //_containerView.backgroundColor = [UIColor redColor];
    }
    return _containerView;
}

-(BackgroundView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[BackgroundView alloc] initWithFrame:self.containerView.bounds];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundView.layer.cornerRadius = 5.f;
        //_backgroundView.alpha = 0.f;
    }
    return _backgroundView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
