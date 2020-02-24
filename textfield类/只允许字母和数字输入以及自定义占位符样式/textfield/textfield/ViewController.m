//
//  ViewController.m
//  textfield
//
//  Created by Gguomingyue on 2019/3/18.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "ViewController.h"

#define NUM @"0123456789"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define HexColor(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0  \
green:((c>>16)&0xFF)/255.0  \
blue:((c>>8)&0xFF)/255.0   \
alpha:((c)&0xFF)/255.0]

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 200, 20)];
    //textfield.placeholder = @"请输入";
    [self.view addSubview:textfield];
    textfield.delegate = self;
    textfield.font = [UIFont systemFontOfSize:15];
    textfield.textColor = HexColor(0x333333ff);
    textfield.placeholder = @"请输入或扫描储蓄卡号";
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入或扫描储蓄卡号" attributes:
    @{NSForegroundColorAttributeName:[UIColor redColor],
      NSFontAttributeName:textfield.font
         }];
    textfield.attributedPlaceholder = attrString;
    //[textfield setValue:[self colorWithRGBString:@"#C8C8C8"] forKeyPath:@"_placeholderLabel.textColor"];
    //[textfield setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    //textfield.keyboardType = UIKeyboardTypeNumberPad;
    textfield.textAlignment = NSTextAlignmentRight;
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //return YES;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

- (UIColor *)colorWithRGBString:(NSString *)color
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1.0];
}


@end
