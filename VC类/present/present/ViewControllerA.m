//
//  ViewControllerA.m
//  VCRunTest
//
//  Created by mingyue on 2022/4/11.
//  Copyright © 2022 Gmingyue. All rights reserved.
//

#import "ViewControllerA.h"
#import "ViewControllerB.h"

@interface ViewControllerA ()

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"next" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    NSLog(@"%@-%@", self, self.presentationController);
    NSLog(@"%@-%@", self, self.presentedViewController);
    NSLog(@"%@-%@", self, self.presentingViewController);
    
}

-(void)btnAction
{
    ViewControllerB * b= [[ViewControllerB alloc] init];
    b.modalPresentationStyle = UIModalPresentationFullScreen;
//    b.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    b.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:b animated:YES completion:nil];
    
    NSLog(@"%@-%@", self, self.presentationController);
    NSLog(@"%@-%@", self, self.presentedViewController);
    NSLog(@"%@-%@", self, self.presentingViewController);
    
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
