//
//  YZVoiceChatSendMessageView.h
//  YZElectCommerce
//
//  Created by mingyue on 2020/7/6.
//  Copyright © 2020 Yaziw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZVoiceChatSendMessageView : UIView

@property (nonatomic, strong) UITextField *textField;
-(void)sendMessage;
-(void)endSendMessage;

@end


