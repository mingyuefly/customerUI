//
//  MYToolbarView.m
//  textFieldKeyBoardOther
//
//  Created by mingyue on 2020/7/7.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "MYToolbarView.h"

@interface MYToolbarView ()

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIView *sendContainerView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *sendMsgButton;

@end

@implementation MYToolbarView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - setup UI
-(void)setupUI
{
    [self addSubview:self.sendButton];
    [self addSubview:self.sendContainerView];
    [self.sendContainerView addSubview:self.textField];
    [self.sendContainerView addSubview:self.sendMsgButton];
}

#pragma mark - actions
-(void)sendButtonAction
{
    [self.textField becomeFirstResponder];
}

-(void)sendMsgButtonAction
{
    
}

-(void)tapAction
{
    [self.textField resignFirstResponder];
}

//监听键盘高度变化
- (void)keyboardFrameDidChange:(NSNotification*)notice {
    if (![self.textField isFirstResponder]) {
        return;
    }
    NSDictionary * userInfo = notice.userInfo;
    NSValue * endFrameValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect endFrame = endFrameValue.CGRectValue;
    [UIView animateWithDuration:0.25 animations:^{
        if (endFrame.origin.y == [UIScreen mainScreen].bounds.size.height) {
            CGRect frame = self.sendContainerView.frame;
            frame.origin.y = endFrame.origin.y;
            self.sendContainerView.frame = frame;
        }else{
            CGRect frame = self.sendContainerView.frame;
            frame.origin.y = endFrame.origin.y - self.sendContainerView.frame.size.height;
            self.sendContainerView.frame = frame;
        }
    }];
}

#pragma mark - property
-(UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setBackgroundColor:[UIColor greenColor]];
        _sendButton.frame = CGRectMake(0, self.bounds.size.height - 30, 100, 30);
        [_sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

-(UIView *)sendContainerView
{
    if (!_sendContainerView) {
        _sendContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 50)];
        _sendContainerView.backgroundColor = [UIColor redColor];
    }
    return _sendContainerView;
}

-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        _textField.placeholder = @"请输入";
        _textField.backgroundColor = [UIColor clearColor];
    }
    return _textField;
}

-(UIButton *)sendMsgButton
{
    if (!_sendMsgButton) {
        _sendMsgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendMsgButton setBackgroundColor:[UIColor greenColor]];
        _sendMsgButton.frame = CGRectMake(260, 10, 60, 30);
        [_sendMsgButton addTarget:self action:@selector(sendMsgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendMsgButton;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
