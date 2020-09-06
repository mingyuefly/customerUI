//
//  YZVoiceChatSendMessageView.m
//  YZElectCommerce
//
//  Created by mingyue on 2020/7/6.
//  Copyright © 2020 Yaziw. All rights reserved.
//

#import "YZVoiceChatSendMessageView.h"
#import "Masonry.h"

@interface YZVoiceChatSendMessageView ()<UITextFieldDelegate>

//@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *emojButton;
@property (nonatomic, strong) UIButton *sendButton;

@end

@implementation YZVoiceChatSendMessageView
#pragma mark - constructors
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark - setup UI
-(void)setupUI
{
    [self addSubview:self.textField];
    [self addSubview:self.emojButton];
    [self addSubview:self.sendButton];
    
    [self addConstraints];
}

#pragma mark - actions
-(void)emojButtonAction
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

-(void)sendAction
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.textField resignFirstResponder];
}

/*
#pragma mark - 监听键盘高度变化
- (void)keyBoardWillShow:(NSNotification *)note {
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height - self.bounds.size.height;
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -keyBoardHeight);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)keyBoardWillHide:(NSNotification *)note
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}
 */

-(void)sendMessage
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.textField becomeFirstResponder];
}

-(void)endSendMessage
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.textField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.textField.text = @"";
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.textField.text = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *textMsg = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (textMsg.length <= 0) {
        textField.text = @"";
        NSLog(@"消息不能为空");
        return YES;
    }
    
    /*
    TCMsgModel *msgModel = [[TCMsgModel alloc] init];
    msgModel.userName = @"我";
    msgModel.userMsg  =  textMsg;
    msgModel.userHeadImageUrl = [[ProfileManager shared] curUserModel].avatar;
    
    if (_bulletBtnIsOn) {
        msgModel.msgType  = TCMsgModelType_DanmaMsg;
        [_liveRoom sendRoomCustomMsgWithCommand:[@(TCMsgModelType_DanmaMsg) stringValue] message:textMsg callback:^(NSInteger code, NSString * error) {
            
        }];
    }else{
        msgModel.msgType = TCMsgModelType_NormalMsg;
        [_liveRoom sendRoomTextMsgWithMessage:textMsg callback:^(NSInteger code, NSString * error) {
            
        }];
    }

    [self bulletMsg:msgModel];
    [_msgInputFeild resignFirstResponder];
     */
    [self.textField resignFirstResponder];
    return YES;
}

#pragma mark - add contraints
-(void)addConstraints
{
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(267);
    }];
    [self.emojButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-64);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.width.mas_equalTo(64);
    }];
}

#pragma mark - property
-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.returnKeyType = UIReturnKeySend;
        _textField.delegate = self;
        _textField.placeholder = @"退下让我说～";
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.textColor = [UIColor blackColor];
    }
    return _textField;
}

-(UIButton *)emojButton
{
    if (!_emojButton) {
        _emojButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emojButton setBackgroundImage:[UIImage imageNamed:@"emojButtonImage"] forState:UIControlStateNormal];
        [_emojButton addTarget:self action:@selector(emojButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojButton;
}

-(UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}


-(void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

@end
