//
//  UILabel+Space.m
//  GLoanClient
//
//  Created by Gguomingyue on 2018/6/20.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import "UILabel+Space.h"

@implementation UILabel (Space)

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

//-(CGFloat)getHeightWithLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace
//{
//    NSString *text = self.text;
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSKernAttributeName:@(wordSpace)}];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:lineSpace];
//    
//    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    
//    paragraphStyle.alignment = NSTextAlignmentLeft;
//    
//    paragraphStyle.hyphenationFactor = 1.0;
//    
//    paragraphStyle.firstLineHeadIndent = 0.0;
//    
//    paragraphStyle.paragraphSpacingBefore = 0.0;
//    
//    paragraphStyle.headIndent = 0;
//    
//    paragraphStyle.tailIndent = 0;
//    
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
//    self.attributedText = attributedString;
//    [self sizeToFit];
//    
//    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@(wordSpace)};
//    CGSize size = [self.text boundingRectWithSize:CGSizeMake(GMLAYOUTRATE(323), 1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//    return size.height;
//}

//-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
//    
//    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
//    
//    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    
//    paraStyle.alignment = NSTextAlignmentLeft;
//    
//    paraStyle.lineSpacing = 5.0f;
//    
//    paraStyle.hyphenationFactor = 1.0;
//    
//    paraStyle.firstLineHeadIndent = 0.0;
//    
//    paraStyle.paragraphSpacingBefore = 0.0;
//    
//    paraStyle.headIndent = 0;
//    
//    paraStyle.tailIndent = 0;
//    
//    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@3.0f
//                          };
//    
//    
//    
//    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 1.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//    
//    return size.height;
//    
//}

@end
