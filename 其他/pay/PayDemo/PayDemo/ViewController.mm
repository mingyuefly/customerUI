//
//  ViewController.m
//  PayDemo
//
//  Created by Gguomingyue on 2018/3/27.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "GMPayManager.h"
#import <AlipaySDK/AlipaySDK.h>

#define currentVersiona  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = @[@"银联", @"支付宝支付", @"微信支付"];
    NSString *str = currentVersiona;
    [AlipaySDK defaultService];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            NSString * orderString = @"745200661042109123601";
            [[GMPayManager shareManager] unionPayOrder:orderString viewController:self];
        }
            break;
        case 1:
        {
            if (![[GMPayManager shareManager] wxAppInstalled]) {
                NSLog(@"未安装微信");
                return;
            }
            
            GMPayWXModel *model = [[GMPayWXModel alloc] init];
            model.openID = @"";//微信开放平台审核通过的应用APPID
            model.partnerId = @"";//商户号
            model.prepayId = @"";//交易会话ID
            model.nonceStr = @"";//随机串，防重发
            model.timeStamp = 1518156229;//时间戳，防重发
            model.package = @"";// 扩展字段,暂填写固定值Sign=WXPay
            model.sign = @"";//签名
            
            [[GMPayManager shareManager] wxpayOrder:model completed:^(NSDictionary *resultDictionary) {
                NSLog(@"支付结果:\n%@",resultDictionary);
                NSInteger code = [resultDictionary[@"errCode"] integerValue];
                if (code == 0) {
                    
                }
            }];
        }
            break;
        case 2:
        {
            if (![[GMPayManager shareManager] aliPayInstalled]) {
                NSLog(@"未安装支付宝");
                
            } else {
                NSString *orderSign = @"2018010801689398&biz_content=%7b%22timeout_express%22%3a%2230m%22%2c%22seller_id%22%3a%22pay%40qianzhan.com%22%2c%22product_code%22%3a%22QUICK_MSECURITY_PAY%22%2c%22total_amount%22%3a%220.01%22%2c%22subject%22%3a%2230%e5%a4%a9%e4%bd%bf%e7%94%a8%e6%9c%9f%e9%99%90%22%2c%22body%22%3a%2230%e5%a4%a9%e4%bd%bf%e7%94%a8%e6%9c%9f%e9%99%90%22%2c%22out_trade_no%22%3a%22data-180209-9913b1d3%22%7d&charset=utf-8&method=alipay.trade.app.pay&notify_url=https%3a%2f%2fappecV2.paipai123.com%2fapi%2fAlipay%2fAliPayNotify&sign_type=RSA2&timestamp=2018-02-23 10%3a54%3a15&version=1.0&sign=d4zihRv9g6OdzI7Tdh64iFarDajKUqcAGWzU9wB29g7X1w6NE5v9Zed2WwCNJFsZf%2fnwtgGQ24m5Ce4%2fxm2jzgyMO2NvRIWnnXO3sUKdBlGNEZeq034j3c3ZZ8L7p830TYRKecaxKt9%2bf%2fkCw67GN1%2bBwgPM1zdAB4xoD%2bqxrtJN79sCuc3xSaBojOWPm%2f9g0bQvd4VBP6ZzxLlbtVt0Yg5Nw2dY0gW4fiEJXfbPeCVW6gSa07bbEb%2fSbbWSgRJfNP%2f%2fi9jkM4Y9%2fLw3Jvj6wH792NUCieWvrIfl6BGiAY6PR0YKLM%2baskr6qkFX3D5H%2bTf6z%2bmf40bT8v74WaBnng%3d%3d";
                [[GMPayManager shareManager] alipayOrder:orderSign fromScheme:@"PayDemo" completed:^(NSDictionary *resultDict) {
                    NSLog(@"支付结果:\n%@",resultDict);
                    NSInteger status = [resultDict[@"resultStatus"] integerValue];
                    if(status == 9000){//支付成功
                        
                    }
                }];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.textLabel.text = self.dataSource[indexPath.row];
    }
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
