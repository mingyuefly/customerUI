//
//  ViewController.m
//  curveView
//
//  Created by mingyue on 16/6/1.
//  Copyright © 2016年 G. All rights reserved.
//

#import "ViewController.h"
#import "CurveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *rateArray = @[@"2.100",@"4.000",@"5.110",@"3.900",@"6.930",@"8.000",@"3.100"];
    NSArray *dateArray = @[@"05-01",@"05-02",@"05-03",@"05-04",@"05-05",@"05-06",@"05-07"];
    CurveView *curveView = [[CurveView alloc]initWithFrame:CGRectMake(0, 100, 320, 162) Date:dateArray Rate:rateArray];
    curveView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:curveView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
