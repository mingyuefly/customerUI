//
//  ViewController.m
//  currentVC
//
//  Created by Gguomingyue on 2019/1/28.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "RedViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"rootVC";
}

- (IBAction)pushAction:(id)sender {
    RedViewController *rvc = [[RedViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}

@end
