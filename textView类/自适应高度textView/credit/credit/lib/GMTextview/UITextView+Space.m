//
//  UITextView+Space.m
//  GLoanClient
//
//  Created by Gguomingyue on 2018/6/20.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import "UITextView+Space.h"

@implementation UITextView (Space)

-(void)setLineSpace:(CGFloat)space
{
    NSString *text = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    self.attributedText = attributedString;
    [self sizeToFit];
}

-(void)setLineSpace:(CGFloat)space Attributed:(NSMutableAttributedString *)attributeString Range:(NSRange)range
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    self.attributedText = attributeString;
    [self sizeToFit];
}

-(void)setwordSpace:(CGFloat)space
{
    NSString *text = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    self.attributedText = attributedString;
    [self sizeToFit];
}

-(void)setLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace
{
    NSString *text = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    self.attributedText = attributedString;
    [self sizeToFit];
}

@end
