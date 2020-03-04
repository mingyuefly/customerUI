//
//  BackgroundView.m
//  MBProgressedHUD
//
//  Created by Gguomingyue on 2018/5/17.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import "BackgroundView.h"

@interface BackgroundView ()

@property UIVisualEffectView *effectView;

@end

@implementation BackgroundView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = MBProgressHUDBackgroundStyleBlur;
        //_style = MBProgressHUDBackgroundStyleSolidColor;
        _blurEffectStyle = UIBlurEffectStyleLight;
        _color = [UIColor colorWithWhite:0.8f alpha:0.6f];
        self.clipsToBounds = YES;
        [self updateForBackgroundStyle];
    }
    return self;
}

- (void)setStyle:(MBProgressHUDBackgroundStyle)style {
    if (_style != style) {
        _style = style;
        [self updateForBackgroundStyle];
    }
}

-(void)updateForBackgroundStyle
{
    MBProgressHUDBackgroundStyle style = self.style;
    if (style == MBProgressHUDBackgroundStyleBlur) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:self.blurEffectStyle];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [self addSubview:effectView];
        effectView.frame = self.bounds;
        effectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = self.color;
        self.layer.allowsGroupOpacity = NO;
        self.effectView = effectView;
    } else {
        [self.effectView removeFromSuperview];
        self.effectView = nil;
        self.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        self.backgroundColor = self.color;
    }
}

@end
