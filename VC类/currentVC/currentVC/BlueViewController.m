//
//  BlueViewController.m
//  currentVC
//
//  Created by Gguomingyue on 2019/1/28.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"blue";
    
    UIViewController *vc = [self activityController];
    UIViewController *nvc = nil;
    UIViewController *mvc = nil;
    NSLog(@"vc = %@", NSStringFromClass([vc class]));
    if ([vc isKindOfClass:[UINavigationController class]]) {
        nvc = [(UINavigationController *)vc topViewController];
        NSLog(@"nvc = %@", NSStringFromClass([nvc class]));
        mvc = [(UINavigationController *)vc visibleViewController];
        NSLog(@"mvc = %@", NSStringFromClass([mvc class]));
    } else {
        
    }
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancelAction];
    //[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    [vc presentViewController:alertVC animated:YES completion:nil];
    //[nvc presentViewController:alertVC animated:YES completion:nil];
    //[mvc presentViewController:alertVC animated:YES completion:nil];
}


-(UIViewController *)activityController
{
    UIViewController *activityController = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel == UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWindow in windows) {
            if (tmpWindow.windowLevel == UIWindowLevelNormal) {
                window = tmpWindow;
                break;
            }
        }
    }
    
    UIViewController *rootVC = window.rootViewController;
    
    while (true) {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            activityController = [(UINavigationController *)rootVC visibleViewController];
        } else if ([rootVC isKindOfClass:[UITabBarController class]]) {
            activityController = [(UITabBarController *)rootVC selectedViewController];
        } else if (rootVC.presentedViewController) {
            activityController = rootVC.presentedViewController;
        } else {
            break;
        }
        rootVC = activityController;
    }
    
    return activityController;
}

@end
