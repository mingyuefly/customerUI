//
//  ViewController.m
//  addWindow
//
//  Created by Gguomingyue on 2018/4/28.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "AViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIWindow *window;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //创建Button，点击创建UIWindow
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [button setTitle:@"创建window" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(creatAction) forControlEvents:UIControlEventTouchUpInside];
    button.center = self.view.center;
    [self.view addSubview:button];
}
-(void)creatAction
{
    AViewController *avc = [[AViewController alloc] init];

    //self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(10, 40, 300, 500)];
    self.window.windowLevel = UIWindowLevelNormal;
    self.window.backgroundColor = [UIColor blackColor];
    self.window.alpha = 0.7;
    self.window.rootViewController = avc;
    self.window.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
