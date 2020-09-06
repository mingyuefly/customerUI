//
//  ViewController.m
//  textFieldKeyboard
//
//  Created by mingyue on 2020/7/6.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "YZVoiceChatSendMessageView.h"

@interface ViewController ()

@property (nonatomic, strong) YZVoiceChatSendMessageView *messageView;
@property (nonatomic, strong) UIView *inputAView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.messageView];
    self.messageView.textField.inputAccessoryView = self.inputAView;
    [self.inputAView addSubview:self.messageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 30);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(100, 200, 100, 30);
    button1.backgroundColor = [UIColor greenColor];
    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

-(void)buttonAction
{
    [self.messageView sendMessage];
}

-(void)button1Action
{
    [self.messageView endSendMessage];
}

-(YZVoiceChatSendMessageView *)messageView
{
    if (!_messageView) {
        _messageView = [[YZVoiceChatSendMessageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 49)];
    }
    return _messageView;
}

-(UIView *)inputAView
{
    if (!_inputAView) {
        _inputAView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
        _inputAView.backgroundColor = [UIColor redColor];
    }
    return _inputAView;
}



@end
