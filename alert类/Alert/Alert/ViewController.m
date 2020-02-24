//
//  ViewController.m
//  Alert
//
//  Created by Gguomingyue on 2019/1/18.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "GMAlertController.h"
#import "UIColor+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)alert:(id)sender {
    /*
    NSString *msg = [NSString stringWithFormat:@"请更新至最新版本,以便我们为您提供更好的借款体验"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有新版本啦" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIView *subView1 = alertController.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    //取title和message：
    //UILabel *title = subView5.subviews[0];
    if ([subView5.subviews[1] isKindOfClass:[UILabel class]]) {
        UILabel *message = subView5.subviews[1];
        //然后设置message内容居左：
        message.textAlignment = NSTextAlignmentLeft;
        //[message setValue:[UIColor redColor] forKey:@"textColor"];
        
    }
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"立即更新"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        
    }];
    
    // Add the actions.
    
    
    [alertController addAction:cancelAction];
    alertController.message = @"建议您更新至最新版本,以便我们为您提供更好的借款体验";
    
    
    [alertController addAction:otherAction];
    
    //UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [self presentViewController:alertController animated:YES completion:nil];
     */
    //1、视觉全面改版，给你更精细的体验；
    //已为您准备好了新版本，是否立即更新？
    
    //GMAlertController *alertController = [GMAlertController alertControllerWithTitle:@"3.0.0易卡全新升级" message:@"1、视觉全面改版，给你更精细的体验；\n2、流程精简优化，想你所想一步到位；\n3、已知BUG修复，我们一直在努力变更好" preferredStyle:UIAlertControllerStyleAlert];
    GMAlertController *alertController = [GMAlertController alertControllerWithTitle:@"发现新版本" message:@"已为您准备好了新版本，是否立即更新?\n*我们一直在努力变得更好" preferredStyle:UIAlertControllerStyleAlert];
    
    GMAlertAction *cancelAction = [GMAlertAction actionWithTitle:@"再等一下" style:UIAlertActionStyleCancel handler:nil];
    cancelAction.textColor = [UIColor colorWithRGBString:@"#999999"];
    GMAlertAction *scanAction = [GMAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *appBaseUrl = @"itms-apps://itunes.apple.com/cn/app/id";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@1136585962", appBaseUrl]]];
    }];
    scanAction.textColor = [UIColor colorWithRGBString:@"#ff8212"];
    
    [alertController addAction:cancelAction];
    [alertController addAction:scanAction];
    
    //alertController.titleColor = [UIColor redColor];
    //alertController.messageAlignment = NSTextAlignmentLeft;
    //alertController.setMessageAlignment = YES;
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    /*
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"有新版本啦" message:@"3.0.0 易卡全新升级：\n1、视觉全面改版，给你更精细的体验；\n2、流程精简优化，想你所想一步到位；\n3、已知BUG修复，我们一直在努力变更好" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"再等一下" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancelAction];
    UIAlertAction *conformAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:conformAction];
    [self presentViewController:alert animated:YES completion:nil];
    */
}


@end
