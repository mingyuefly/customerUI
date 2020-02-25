//
//  ViewController.m
//  CustomActionSheet
//
//  Created by Gguomingyue on 2018/1/9.
//  Copyright © 2018年 Gguomingyue. All rights reserved.
//

#import "ViewController.h"
#import "MYActionSheetViewController.h"

@interface ViewController ()

- (IBAction)custom:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)custom:(UIButton *)sender {
    MYActionSheetViewController *asvc = [MYActionSheetViewController ActionSheetViewController];
    MYSheetAction *cancelAction = [MYSheetAction actionWithTitle:@"取消" hander:nil];
    [asvc addCancelAction:cancelAction];
    MYSheetAction *cameraAction = [MYSheetAction actionWithTitle:@"拍照" hander:^(MYSheetAction *action) {
        NSLog(@"拍照");
        
    }];
    [asvc addAction:cameraAction];
    MYSheetAction *photoAction = [MYSheetAction actionWithTitle:@"从相册中选择" hander:^(MYSheetAction *action) {
        NSLog(@"从相册中选择");
        
    }];
    [asvc addAction:photoAction];
    [asvc presentWith:self animated:YES completion:nil];
}
@end
