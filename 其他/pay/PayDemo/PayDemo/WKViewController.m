//
//  WKViewController.m
//  PayDemo
//
//  Created by Gguomingyue on 2018/4/2.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import "WKViewController.h"
#import <WebKit/WebKit.h>

@interface WKViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString: @"https://openapi.alipay.com/gateway.do"];
    NSString *body = [NSString stringWithFormat: @"arg1=%@&arg2=%@", @"val1",@"val2"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.webView loadRequest: request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
