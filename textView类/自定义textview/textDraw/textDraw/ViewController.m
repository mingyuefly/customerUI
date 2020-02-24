//
//  ViewController.m
//  textDraw
//
//  Created by Gguomingyue on 2019/2/28.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "MYTextView.h"

@interface ViewController ()

@property (nonatomic, strong) MYTextView *tview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tview = [[MYTextView alloc] initWithFrame:self.view.bounds];
    self.tview = [[MYTextView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.tview.center = self.view.center;
    self.tview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tview];
}


@end
