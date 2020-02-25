//
//  AppDelegate.m
//  LazyTable
//
//  Created by mingyue on 16/5/27.
//  Copyright © 2016年 csii. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "ParseOperation.h"
#import "AppRecord.h"


static NSString *const TopPaidAppsFeed =
@"http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=75/xml";

@interface AppDelegate ()

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) ParseOperation *parser;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:TopPaidAppsFeed]];
    NSURLSessionDataTask *sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                if ([error code] == NSURLErrorAppTransportSecurityRequiresSecureConnection) {
                    abort();
                } else {
                    [self handleError:error];
                }

            }];
        } else {
            self.queue = [[NSOperationQueue alloc]init];
            _parser = [[ParseOperation alloc]initWithData:data];
            __weak AppDelegate *weakSelf = self;
            self.parser.errorHandler = ^(NSError *parseError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [weakSelf handleError:parseError];
                });
            };
            __weak ParseOperation *weakParser = self.parser;
            self.parser.completionBlock = ^(void) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                });
            
                if (weakParser.appRecordList != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        RootViewController *rootViewController = (RootViewController *)[(UINavigationController *)weakSelf.window.rootViewController topViewController];
                        rootViewController.entries = weakParser.appRecordList;
                        [rootViewController.tableView reloadData];
                    });
                }
                weakSelf.queue = nil;
            };
            [self.queue addOperation:self.parser];
        }
    }];
    
    [sessionTask resume];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    return YES;
}


-(void)handleError:(NSError *)error {

    NSString *errorMessage = [error localizedDescription];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Show Top Paid Apps" message:errorMessage preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert addAction:OKAction];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }];
}








@end
