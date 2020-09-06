//
//  ViewController.m
//  tintButton
//
//  Created by mingyue on 2020/6/26.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    //self.view.opaque = NO;
    
    // 设置UIButtonTypeSystem，后tintColor为tilte和image的默认color，如果不设置tintColor，则tintColor为superView的默认backgroundColor。
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 30);
    //button.opaque = NO;
    //button.tintColor = [UIColor redColor];
    [button setTintColor:[UIColor greenColor]];
    //button.backgroundColor = [UIColor redColor];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)action
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


@end
