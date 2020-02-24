//
//  ViewController.m
//  buttonMask
//
//  Created by Gguomingyue on 2018/5/18.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    //backView.alpha = 0;
    backView.userInteractionEnabled = NO;
    //backView.userInteractionEnabled = YES;
    [self.view addSubview:backView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //button.frame = CGRectMake(10, 10, 100, 30);
    button.frame = CGRectMake(10+100, 10+100, 100, 30);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"touch" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    //[backView addSubview:button];
    [self.view addSubview:button];
    //[self.view addSubview:backView];
    
}

-(void)buttonAction
{
    NSLog(@"buttonAction");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
