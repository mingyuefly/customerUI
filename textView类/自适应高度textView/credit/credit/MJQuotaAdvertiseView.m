//
//  MJQuotaAdvertiseView.m
//  credit
//
//  Created by Gguomingyue on 2018/12/19.
//  Copyright © 2018 Gmingyue. All rights reserved.
//

#import "MJQuotaAdvertiseView.h"
#import "defines.h"
#import "UIColor+Extension.h"
#import "Masonry.h"
#import "GMLayoutRate.h"

@interface MJQuotaAdvertiseView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *completeButton;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation MJQuotaAdvertiseView
#pragma mark - constructors
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRGBString:@"#000000" Alpha:0.4];
        [self setupUI];
    }
    return self;
}

#pragma mark - setup UI
-(void)setupUI
{
    [self addSubview:self.imageView];
    [self addSubview:self.completeButton];
    [self addSubview:self.backButton];
    
    [self addConstraints];
}

#pragma mark - actions
-(void)backAction
{
    NSLog(@"backAction");
    [self removeFromSuperview];
    if (self.backBlock) {
        self.backBlock();
    }
}

-(void)completeAction
{
    NSLog(@"completeAction");
    [self removeFromSuperview];
    if (self.completeBlock) {
        self.completeBlock();
    }
}

#pragma mark - add constraits
-(void)addConstraints
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-GMLAYOUTRATE(157));
        make.size.mas_equalTo(CGSizeMake(GMLAYOUTRATE(300), GMLAYOUTRATE(400)));
    }];
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-GMLAYOUTRATE(196));
        make.size.mas_equalTo(CGSizeMake(GMLAYOUTRATE(260), GMLAYOUTRATE(45)));
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-GMLAYOUTRATE(173));
        make.size.mas_equalTo(CGSizeMake(GMLAYOUTRATE(80), GMLAYOUTRATE(12)));
    }];
}

#pragma mark - getters and setters
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.image = [UIImage imageNamed:@"quotaAdvertisePlaceholderImage"];
    }
    return _imageView;
}

-(UIButton *)completeButton
{
    if (!_completeButton) {
        _completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_completeButton setBackgroundImage:[UIImage imageNamed:@"continueCompleteImage"] forState:UIControlStateNormal];
        [_completeButton addTarget:self action:@selector(completeAction) forControlEvents:UIControlEventTouchUpInside];
        [_completeButton setTitle:@"继续完善实名信息" forState:UIControlStateNormal];
        [_completeButton setTitleColor:[UIColor colorWithRGBString:@"#C8622A"] forState:UIControlStateNormal];
        _completeButton.titleLabel.font = font17;
    }
    return _completeButton;
}

-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor = [UIColor clearColor];
        [_backButton setTitle:@"执意退出" forState:UIControlStateNormal];
        _backButton.titleLabel.font = font12;
        [_backButton setTitleColor:[UIColor colorWithRGBString:@"#F9F0CF"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
