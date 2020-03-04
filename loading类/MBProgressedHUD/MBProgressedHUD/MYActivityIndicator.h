//
//  MYActivityIndicator.h
//  MBProgressedHUD
//
//  Created by Gguomingyue on 2018/5/17.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MYActivityIndicator : NSObject

@property (nonatomic, strong) MBProgressHUD *activityIndicator;
@property (nonatomic, weak) UIView *showView;
@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, copy) NSString *detailLabelText;
@property (nonatomic, assign) float progress;

+(instancetype)sharedInstance;
-(void)addToShowView:(UIView *)showView;

@end
