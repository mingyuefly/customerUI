//
//  GMAlertController.m
//  GmLoanClient
//
//  Created by Gguomingyue on 2016/12/15.
//  Copyright © 2016年 GFinance. All rights reserved.
//

#import "GMAlertController.h"
#import <objc/runtime.h>

@implementation GMAlertAction

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UIAlertAction class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        if ([ivarName isEqualToString:@"_titleTextColor"]) {
            [self setValue:textColor forKey:@"titleTextColor"];
        }
    }
}

@end

@implementation GMAlertController

-(instancetype)init
{
    if (self = [super init]) {
        self.setMessageAlignment = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UIAlertAction class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        
        //标题颜色
        if ([ivarName isEqualToString:@"_attributedTitle"] && self.title && self.titleColor) {
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{NSForegroundColorAttributeName:self.titleColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0]}];
            [self setValue:attribute forKey:@"attributedTitle"];
        }
        //描述颜色
        if ([ivarName isEqualToString:@"_attributedMessage"]) {
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.message attributes:@{NSForegroundColorAttributeName:self.message, NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
            [self setValue:attribute forKey:@"attributedMessage"];
        }
        
        //message字体居中
        if ([ivarName isEqualToString:@"_titleTextAlignment"]) {
            //[self setValue:@(NSTextAlignmentCenter) forKey:@"titleTextAlignment"];
        }
    }
    
    /*****获取alert的title和message控件*****//*
                                        if (self.view.subviews.count > 0) {
                                        UIView *subView1 = self.view.subviews[0];
                                        if (subView1.subviews.count > 0) {
                                        UIView *subView2 = subView1.subviews[0];
                                        if (subView2.subviews.count > 0) {
                                        UIView *subView3 = subView2.subviews[0];
                                        if (subView3.subviews.count > 0) {
                                        UIView *subView4 = subView3.subviews[0];
                                        if (subView4.subviews.count > 0) {
                                        UIView *subView5 = subView4.subviews[0];
                                        NSLog(@"%@",subView5.subviews);
                                        if (subView5.subviews.count > 1) {
                                        //取title和message：
                                        //UILabel *title = subView5.subviews[0];
                                        UILabel *message = subView5.subviews[1];
                                        if (self.setMessageAlignment) {
                                        message.textAlignment = self.messageAlignment;
                                        } else {
                                        //
                                        }
                                        }
                                        
                                        }
                                        
                                        }
                                        
                                        }
                                        
                                        }
                                        
                                        }
                                        /**********/
    
    /*****获取alert的title和message控件*****/
    UIView *messageParentView = [self getParentViewOfTitleAndMessageFromView:self.view];
    if (messageParentView && messageParentView.subviews.count > 1) {
        UILabel *titleLabel = nil;
        UILabel *messageLabel = nil;
        for (UIView *subView in messageParentView.subviews) {
            if ([subView isKindOfClass:[UILabel class]]) {
                if (!titleLabel) {
                    titleLabel = (UILabel *)subView;
                } else {
                    messageLabel = (UILabel *)subView;
                }
            }
        }
        //UILabel *titleLabel = messageParentView.subviews[1];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        //UILabel *messageLabel = messageParentView.subviews[2];
        messageLabel.textAlignment = NSTextAlignmentLeft|NSTextAlignmentJustified;
        //messageLabel.textAlignment = NSTextAlignmentJustified;
        
        /**********label上文字两端对齐***********
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageLabel.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        //设置label每行文字之间的行间距
        //    paragraphStyle1.lineSpacing=8;
        //设置文字两端对齐
        paragraphStyle1.alignment=NSTextAlignmentJustified;
        NSDictionary * dic =@{
                              //这两个一定要加哦。否则就没效果啦
                              NSParagraphStyleAttributeName:paragraphStyle1,
                              NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone],
                              };
        
        [attributedString1 setAttributes:dic range:NSMakeRange(0, attributedString1.length)];
        [messageLabel setAttributedText:attributedString1];
        *********/
        
        
    }
    /**********/
    
    //按钮统一颜色
    if (self.tintColor) {
        for (GMAlertAction *action in self.actions) {
            if (!action.textColor) {
                action.textColor = self.tintColor;
            }
        }
    }
}

- (UIView *)getParentViewOfTitleAndMessageFromView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            return view;
        }else{
            UIView *resultV = [self getParentViewOfTitleAndMessageFromView:subView];
            if (resultV) return resultV;
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
