//
//  ViewController.m
//  VCRunTest
//
//  Created by mingyue on 2022/4/11.
//  Copyright © 2022 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerA.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"next" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)btnAction
{
    ViewControllerA * a= [[ViewControllerA alloc] init];
    a.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:a animated:YES completion:nil];
    
    NSLog(@"%@-%@", self, self.presentationController);
    NSLog(@"%@-%@", self, self.presentedViewController);
    NSLog(@"%@-%@", self, self.presentingViewController);
}

@end
