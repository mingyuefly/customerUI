//
//  ViewControllerB.m
//  VCRunTest
//
//  Created by mingyue on 2022/4/11.
//  Copyright © 2022 Gmingyue. All rights reserved.
//

#import "ViewControllerB.h"
#import "ViewControllerC.h"

@interface ViewControllerB ()

@end

@implementation ViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"next" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postAction) name:@"post" object:nil];
    
    NSLog(@"%@-%@", self, self.presentationController);
    NSLog(@"%@-%@", self, self.presentedViewController);
    NSLog(@"%@-%@", self, self.presentingViewController);
    
}

-(void)btnAction
{
    ViewControllerC * c= [[ViewControllerC alloc] init];
    c.modalPresentationStyle = UIModalPresentationFullScreen;
    c.vb = self;
    [self presentViewController:c animated:YES completion:nil];
    
    NSLog(@"%@-%@", self, self.presentationController);
    NSLog(@"%@-%@", self, self.presentedViewController);
    NSLog(@"%@-%@", self, self.presentingViewController);
    
}

-(void)postAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
