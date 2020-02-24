//
//  GMAlertController.h
//  GmLoanClient
//
//  Created by Gguomingyue on 2016/12/15.
//  Copyright © 2016年 GFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMAlertAction : UIAlertAction

@property (nonatomic, strong) UIColor *textColor;

@end

@interface GMAlertController : UIAlertController

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, assign) NSTextAlignment messageAlignment;
@property (nonatomic, assign) BOOL setMessageAlignment;

@end
