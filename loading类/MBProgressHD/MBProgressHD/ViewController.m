//
//  ViewController.m
//  MBProgressHD
//
//  Created by Gguomingyue on 2019/12/5.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "OCRLoadingView.h"

@interface ViewController ()<MBProgressHUDDelegate>

//@property (nonatomic, strong) OCRLoadingView *loadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    //UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    __block MBProgressHUD *progressView = [[MBProgressHUD alloc] initWithView:self.view];
//    progressView.customView = self.loadingView;
//    progressView.mode = MBProgressHUDModeCustomView;
//    progressView.animationType = MBProgressHUDAnimationFade;
//    [progressView showAnimated:YES];
//    progressView.delegate = self;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [progressView setAnimationType:MBProgressHUDAnimationZoomOut];
//        [progressView hideAnimated:YES afterDelay:0.1f];
//    });
    
    //[self.view addSubview:self.loadingView];
    //self.loadingView.transform = CGAffineTransformMakeRotation(M_PI_2);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [OCRLoadingView show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [OCRLoadingView dismiss];
    });
}

#pragma mark - property
//-(OCRLoadingView *)loadingView
//{
//    if (!_loadingView) {
//        _loadingView = [[OCRLoadingView alloc] initWithFrame:self.view.bounds];
//    }
//    return _loadingView;
//}

@end
