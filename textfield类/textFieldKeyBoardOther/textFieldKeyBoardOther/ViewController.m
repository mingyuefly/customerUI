//
//  ViewController.m
//  textFieldKeyBoardOther
//
//  Created by mingyue on 2020/7/7.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "MYToolbarView.h"

@interface ViewController ()

@property (nonatomic, strong) MYToolbarView *toolbarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.toolbarView];
    
    UIView *archorView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    archorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:archorView];
}

-(MYToolbarView *)toolbarView
{
    if (!_toolbarView) {
        _toolbarView = [[MYToolbarView alloc] initWithFrame:self.view.bounds];
    }
    return _toolbarView;
}


@end
