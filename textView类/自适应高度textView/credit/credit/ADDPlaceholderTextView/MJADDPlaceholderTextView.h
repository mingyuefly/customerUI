//
//  ADDPlaceholderTextView.h
//  GmLoanClient
//
//  Created by mingyue on 16/7/8.
//  Copyright © 2016年 GFinance. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MJADDPlaceholderTextViewDelegate <NSObject>

@optional
    
- (void)textViewDidChangeWithTextView:(UITextView *)textView;
    

@end

@interface MJADDPlaceholderTextView : UIView

@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy) NSString *inputText;
@property (nonatomic, weak) id<MJADDPlaceholderTextViewDelegate> delegate;


-(instancetype)initWithFrame:(CGRect)frame Placeholder:(NSString *)placeholder PlaceholderColor:(UIColor *)placeholderColor TextColor:(UIColor *)textColor BackgroundColor:(UIColor *)backgroundColor BorderColor:(UIColor *)borderColor;
    
    


@end
