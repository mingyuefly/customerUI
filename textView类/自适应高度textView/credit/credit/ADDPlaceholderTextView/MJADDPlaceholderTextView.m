//
//  ADDPlaceholderTextView.m
//  GmLoanClient
//
//  Created by mingyue on 16/7/8.
//  Copyright © 2016年 GFinance. All rights reserved.
//

#import "MJADDPlaceholderTextView.h"
#import "UIColor+Extension.h"
#import "defines.h"
#import "UITextView+Space.h"
#import "GMLayoutRate.h"

@interface MJADDPlaceholderTextView () <UITextViewDelegate>

@property (nonatomic, copy) NSString *gm_placeholder;
@property (nonatomic, strong) UIColor *gm_placeholderColor;
@property (nonatomic, strong) UIColor *gm_textColor;
@property (nonatomic, strong) UIColor *gm_backColor;
@property (nonatomic, strong) UIColor *gm_borderColor;
@property (nonatomic, strong) UITextView *placeholderView;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation MJADDPlaceholderTextView

#pragma mark - constructed functions

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame Placeholder:(NSString *)placeholder PlaceholderColor:(UIColor *)placeholderColor TextColor:(UIColor *)textColor BackgroundColor:(UIColor *)backgroundColor BorderColor:(UIColor *)borderColor
{
    self = [self initWithFrame:frame];
    if (self) {
        self.gm_placeholder = placeholder;
        self.gm_placeholderColor = placeholderColor;
        self.gm_textColor = textColor;
        self.gm_backColor = backgroundColor;
        self.gm_borderColor = borderColor;
        
        [self setupUI];
    }
    return self;
}

#pragma mark - setupUI
-(void)setupUI
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.placeholderView];
    [self addSubview:self.textView];
    [self contentSizeToFit:self.textView];
    [self contentSizeToFit:self.placeholderView];
}

- (void)contentSizeToFit:(UITextView *)textView;
{
    CGSize contentSize = textView.contentSize;
    UIEdgeInsets offset;
    if (textView == self.textView && textView.text && textView.text.length > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:GMLAYOUTRATE(8.0f)];
        NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:font15};
        textView.typingAttributes = attributes;
    }
    
    CGFloat offsetY = (textView.frame.size.height - contentSize.height)/2;
    offset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
    [textView setContentInset:offset];
}

- (void)contentSizeToFitNoEdit:(UITextView *)textView;
{
    CGSize contentSize = textView.contentSize;
    UIEdgeInsets offset;
    
    CGFloat offsetY = (textView.frame.size.height - contentSize.height)/2;
    offset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
    [textView setContentInset:offset];
}

#pragma mark - getters
-(UITextView *)placeholderView
{
    if (!_placeholderView) {
        _placeholderView = [[UITextView alloc] init];
        _placeholderView.frame = self.bounds;
        _placeholderView.delegate = self;
        _placeholderView.backgroundColor = [UIColor clearColor];
        _placeholderView.font = font15;
        _placeholderView.text = @"请填写详细地址";
        _placeholderView.textColor = [UIColor colorWithRGBString:@"#C8C8C8"];
        [_placeholderView setEditable:NO];
    }
    return _placeholderView;
}

-(UITextView *)textView
{
    if (!_textView) {
        
        //创建container
        NSTextContainer *container = [[NSTextContainer alloc] initWithSize:_textView.bounds.size];
        container.widthTracksTextView = YES;
        //创建layoutManager并添加container
        NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
        [layoutManager addTextContainer:container];
        //创建storage并添加layoutManager
        NSTextStorage *storage = [[NSTextStorage alloc] init];
        [storage addLayoutManager:layoutManager];
        
        _textView = [[UITextView alloc] initWithFrame:self.bounds textContainer:container];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = font15;
        _textView.textAlignment = NSTextAlignmentLeft;
        //_textView.text = @"V爱的";
    }
    return _textView;
}

-(NSString *)text
{
    return self.textView.text;
}

-(void)setInputText:(NSString *)inputText
{
    _inputText = inputText;
    self.textView.text = _inputText;
    if (_inputText && _inputText.length > 0) {
        self.placeholderView.hidden = YES;
        //[self.textView.textStorage beginEditing];
        //[self contentSizeToFitNoEdit:self.textView];
        //[self contentSizeToFit:self.placeholderView];
    }
}

#pragma mark---UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeholderView.hidden = NO;
    } else {
        self.placeholderView.hidden = YES;
    }
    
    [self contentSizeToFit:self.textView];
    [self contentSizeToFit:self.placeholderView];
    
    if ([self.delegate respondsToSelector:@selector(textViewDidChangeWithTextView:)]) {
        [self.delegate textViewDidChangeWithTextView:textView];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return [text isEqualToString:@""]?YES:textView.text.length + (textView.text.length - range.length) <= 200;
}

@end
