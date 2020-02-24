//
//  ViewController.m
//  credit
//
//  Created by Gguomingyue on 2018/12/18.
//  Copyright © 2018 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "MJCreditInvestigationView.h"
#import "MJQuotaAdvertiseView.h"
#import "defines.h"
#import "GMLayoutRate.h"
#import "TableViewController.h"

@interface ViewController ()

@property (nonatomic, strong) MJCreditInvestigationView *creditInvestigationView;
@property (nonatomic, strong) MJQuotaAdvertiseView *quotaAdertiseView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.view addSubview:self.creditInvestigationView];
    //[self.view addSubview:self.quotaAdertiseView];
}

- (IBAction)nextAction:(id)sender {
    TableViewController *tvc = [[TableViewController alloc] init];
    [self.navigationController pushViewController:tvc animated:YES];
}


-(MJCreditInvestigationView *)creditInvestigationView
{
    if (!_creditInvestigationView) {
        _creditInvestigationView = [[MJCreditInvestigationView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _creditInvestigationView.protocolblock = ^(NSURL *url) {
            NSLog(@"url = %@", [url scheme]);
        };
        _creditInvestigationView.applyBlock = ^{
            NSLog(@"applyBlock");
        };
        _creditInvestigationView.backBlock = ^{
            NSLog(@"backBlock");
        };
        _creditInvestigationView.agreements = @[@{@"contractName":@"电子签名约定书",@"contractType" : @"6"},@{@"contractName":@"安心签平台服务协议",@"contractType" : @"7"},@{@"contractName":@"国美易卡额度服务协议",@"contractType" : @"9"},@{@"contractName":@"信用查询授权书",@"contractType" : @"3"}];
    }
    return _creditInvestigationView;
}

-(MJQuotaAdvertiseView *)quotaAdertiseView
{
    if (!_quotaAdertiseView) {
        _quotaAdertiseView = [[MJQuotaAdvertiseView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _quotaAdertiseView.completeBlock = ^{
            NSLog(@"completeBlock");
        };
        _quotaAdertiseView.backBlock = ^{
            NSLog(@"backBlock");
        };
    }
    return _quotaAdertiseView;
}


@end
