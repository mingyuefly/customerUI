//
//  MYTextView.m
//  textDraw
//
//  Created by Gguomingyue on 2019/2/28.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "MYTextView.h"
#import <CoreText/CoreText.h>

@implementation MYTextView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

/*
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    // 步骤1：得到当前用于绘制画布的上下文，用于后续将内容绘制在画布上
    // 因为Core Text要配合Core Graphic 配合使用的，如Core Graphic一样，绘图的时候需要获得当前的上下文进行绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 步骤2：翻转当前的坐标系（因为对于底层绘制引擎来说，屏幕左下角为（0，0））
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // 步骤3：创建NSAttributedString
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"iOS程序在启动时会创建一个主线程，而在一个线程只能执行一件事情，如果在主线程执行某些耗时操作，例如加载网络图片，下载资源文件等会阻塞主线程（导致界面卡死，无法交互），所以就需要使用多线程技术来避免这类情况。iOS中有三种多线程技术 NSThread，NSOperation，GCD，这三种技术是随着IOS发展引入的，抽象层次由低到高，使用也越来越简单。"];
    
    // 步骤4：根据NSAttributedString创建CTFramesetterRef
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    
    // 步骤5：创建绘制区域CGPathRef
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, self.bounds);
    [[UIColor redColor]set];
    CGContextFillEllipseInRect(context, self.bounds);
    
    // 步骤6：根据CTFramesetterRef和CGPathRef创建CTFrame；
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attrString length]), path, NULL);
    
    // 步骤7：CTFrameDraw绘制
    CTFrameDraw(frame, context);
    
    // 步骤8.内存管理
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}
 */


- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    //步骤1：获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //步骤2：翻转坐标系；
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height);
    //将当前context的坐标系进行flip
    CGContextConcatCTM(context, flipVertical);
    
    //步骤3：创建NSAttributedString
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc]initWithString:@"在现实生活中，我们要不断内外兼修，几十载的人生旅途，看过这边风景，必然错过那边彩虹，有所得，必然有所失。有时，我们只有彻底做到拿得起，放得下，才能拥有一份成熟，才会活得更加充实、坦然、轻松和自由。"];
    //设置部分颜色
    [attributeString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor greenColor].CGColor range:NSMakeRange(10, 10)];
    //设置部分文字
    CGFloat fontSize = 20;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    [attributeString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(15, 10)];
    CFRelease(fontRef);
    // 设置行距等样式
    CGFloat lineSpace = 10; // 行距一般取决于这个值
    CGFloat lineSpaceMax = 20;
    CGFloat lineSpaceMin = 2;
    const CFIndex kNumberOfSettings = 3;
    // 结构体数组
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpace},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpaceMax},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpaceMin}
        
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    // 单个元素的形式
    // CTParagraphStyleSetting theSettings = {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpace};
    // CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(&theSettings, kNumberOfSettings);
    // 两种方式皆可
    // [attributed addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)theParagraphRef range:NSMakeRange(0, attributed.length)];
    
    [attributeString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge  id)theParagraphRef range:NSMakeRange(0, attributeString.length)];
    CFRelease(theParagraphRef);
    
    //步骤4：根据NSAttributedString创建CTFramesetterRef
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeString);
    
    //步骤5：创建绘制区域CGPathRef
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, CGRectInset(self.bounds, 0, 20));
    
    //步骤6：根据CTFramesetterRef和CGPathRef创建CTFrame；
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, [attributeString length]), pathRef, NULL);
    
    //步骤7：CTFrameDraw绘制。
    CTFrameDraw(frameRef, context);
    
    
    //内存管理
    CFRelease(frameRef);
    CFRelease(pathRef);
    CFRelease(framesetterRef);
}


@end
