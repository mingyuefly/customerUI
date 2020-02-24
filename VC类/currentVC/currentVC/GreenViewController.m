//
//  GreenViewController.m
//  currentVC
//
//  Created by Gguomingyue on 2019/1/28.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "GreenViewController.h"
#import "BlueViewController.h"

@interface GreenViewController ()

@end

@implementation GreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"green";
}

- (IBAction)presentAction:(id)sender {
    BlueViewController *bvc = [[BlueViewController alloc] initWithNibName:@"BlueViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bvc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}


@end
