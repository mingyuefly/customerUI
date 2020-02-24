//
//  RedViewController.m
//  currentVC
//
//  Created by Gguomingyue on 2019/1/28.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "RedViewController.h"
#import "GreenViewController.h"

@interface RedViewController ()

@end

@implementation RedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"red";
}

- (IBAction)pushAction:(id)sender {
    GreenViewController *gvc = [[GreenViewController alloc] init];
    [self.navigationController pushViewController:gvc animated:YES];
}




@end
