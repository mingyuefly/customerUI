//
//  OCRLoadingView.m
//  meijie
//
//  Created by Gguomingyue on 2019/12/4.
//  Copyright © 2019 G. All rights reserved.
//

#import "OCRLoadingView.h"
#import "Masonry.h"

static OCRLoadingView *_ocrLoadingView;

@interface OCRLoadingView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *animationImageView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation OCRLoadingView
#pragma mark - constructors
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

#pragma mark - setup UI
-(void)setupUI
{
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.animationImageView];
    [self.containerView addSubview:self.tipLabel];
    
    [self addConstraints];
}

-(void)addConstraints
{
    __weak typeof(self) weakSelf = self;
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(124, 87.5));
    }];
    [self.animationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.containerView);
        make.top.equalTo(weakSelf.containerView).offset(20);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.containerView);
        make.top.equalTo(weakSelf.containerView).offset(53.5);
    }];
}

#pragma mark - class methods
+(void)show
{
    if (!_ocrLoadingView) {
        _ocrLoadingView = [[self alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview:_ocrLoadingView];
}

+(void)dismiss
{
    if (_ocrLoadingView) {
        [_ocrLoadingView removeFromSuperview];
    }
}

#pragma mark - layout subviews
-(void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - property
-(UIImageView *)animationImageView
{
    if (!_animationImageView) {
        _animationImageView = [[UIImageView alloc] init];
        _animationImageView.image = [UIImage imageNamed:@"MJCutomerCamaraLoadingImage"];
        _animationImageView.contentMode = UIViewContentModeScaleToFill;
        
        CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animation.fromValue = @(0);
        animation.toValue = @(2 * M_PI);
        animation.duration = 1.0f;
        animation.repeatCount = INFINITY;
        animation.removedOnCompletion = NO;
        animation.timingFunction = linearCurve;
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses = NO;
        
        [_animationImageView.layer addAnimation:animation forKey:@"keyFrameAnimation"];
    }
    return _animationImageView;
}

-(UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.text = @"卡号识别中…";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:14];
    }
    return _tipLabel;
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        UIColor *color = [UIColor blackColor];
        UIColor *cl = [color colorWithAlphaComponent:0.6];
        _containerView.backgroundColor = cl;
        _containerView.layer.cornerRadius = 4.0f;
        _containerView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    return _containerView;
}

@end
