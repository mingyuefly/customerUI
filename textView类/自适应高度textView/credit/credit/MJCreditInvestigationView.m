//
//  MJCreditInvestigationView.m
//  credit
//
//  Created by Gguomingyue on 2018/12/18.
//  Copyright © 2018 Gmingyue. All rights reserved.
//

#import "MJCreditInvestigationView.h"
#import "defines.h"
#import "UIColor+Extension.h"
#import "Masonry.h"
#import "GMLayoutRate.h"
#import "UITextView+Space.h"
#import "UILabel+Space.h"

@interface MJCreditInvestigationView () <UITextViewDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *agreeLabel;
@property (nonatomic, strong) UITextView *urlTextView;
@property (nonatomic, strong) UIButton *applyButton;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation MJCreditInvestigationView
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
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.closeButton];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.subTitleLabel];
    [self.containerView addSubview:self.imageView];
    [self.containerView addSubview:self.agreeLabel];
    [self.containerView addSubview:self.urlTextView];
    [self.containerView addSubview:self.applyButton];
    [self.containerView addSubview:self.backButton];
    
    [self addConstraints];
}

#pragma mark - add constraints
-(void)addConstraints
{
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(GMLAYOUTRATE(20));
        make.top.equalTo(self.containerView).offset(GMLAYOUTRATE(15));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(GMLAYOUTRATE(20));
        make.centerY.equalTo(self.containerView.mas_top).offset(GMLAYOUTRATE(45 + 25/2));
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(GMLAYOUTRATE(20));
        make.centerY.equalTo(self.containerView.mas_top).offset(GMLAYOUTRATE(83 + 18/2));
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView);
        make.top.equalTo(self.containerView).offset(GMLAYOUTRATE(114));
        make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH, GMLAYOUTRATE(215)));
    }];
    [self.agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(GMLAYOUTRATE(64));
        make.centerY.equalTo(self.imageView.mas_top).offset(GMLAYOUTRATE(38 + 50/2));
        make.width.mas_equalTo(DEVICE_WIDTH - GMLAYOUTRATE(64 + 61));
    }];
    [self.urlTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(GMLAYOUTRATE(64));
        make.centerY.equalTo(self.imageView.mas_top).offset(GMLAYOUTRATE(GMLAYOUTRATE(108 + 70/2)));
        make.width.mas_equalTo(DEVICE_WIDTH - GMLAYOUTRATE(64 + 56));
    }];
    [self.applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.bottom.equalTo(self.containerView).offset(-GMLAYOUTRATE(51));
        make.size.mas_equalTo(CGSizeMake(GMLAYOUTRATE(160), GMLAYOUTRATE(45)));
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.bottom.equalTo(self.containerView).offset(-GMLAYOUTRATE(20));
        make.size.mas_equalTo(CGSizeMake(GMLAYOUTRATE(73), GMLAYOUTRATE(12)));
    }];
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    NSLog(@"[URL scheme] = %@",[URL scheme]);
    if (URL) {
        if (self.protocolblock) {
            self.protocolblock(URL);
        }
        return NO;
    }
    return YES;
}

#pragma mark - actions
-(void)closeAction
{
    NSLog(@"closeAction");
    [self removeFromSuperview];
}

-(void)applyAction
{
    NSLog(@"applyAction");
    [self removeFromSuperview];
    if (self.applyBlock) {
        self.applyBlock();
    }
}

-(void)backAction
{
    NSLog(@"backAction");
    [self removeFromSuperview];
    if (self.backBlock) {
        self.backBlock();
    }
}

#pragma mark - getters and setters
-(UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"closeImage"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = boldfont23;
        _titleLabel.textColor = [UIColor colorWithRGBString:@"#141414"];
        _titleLabel.text = @"阅读并同意个人征信授权书";
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        _subTitleLabel.font = font12;
        _subTitleLabel.textColor = [UIColor colorWithRGBString:@"#999999"];
        _subTitleLabel.text = @"查询个人征信，有利于获取更高额度";
    }
    return _subTitleLabel;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.image = [UIImage imageNamed:@"agreeCreditImage"];
    }
    return _imageView;
}

-(UILabel *)agreeLabel
{
    if (!_agreeLabel) {
        _agreeLabel = [[UILabel alloc] init];
        _agreeLabel.backgroundColor = [UIColor clearColor];
        _agreeLabel.textAlignment = NSTextAlignmentLeft;
        _agreeLabel.font = font12;
        _agreeLabel.textColor = [UIColor colorWithRGBString:@"#141414"];
        _agreeLabel.text = @"本人同意授权国美小贷在业务存续期内向国家设立的金融信用信息基础数据库报送、查询、打印、保存和使用本人的信用信息";
        _agreeLabel.numberOfLines = 0;
        [_agreeLabel setLineSpace:GMLAYOUTRATE(4.0f)];
    }
    return _agreeLabel;
}

-(UITextView *)urlTextView
{
    if (!_urlTextView) {
        _urlTextView = [[UITextView alloc] init];
        _urlTextView.backgroundColor = [UIColor clearColor];
        _urlTextView.textColor = [UIColor colorWithRGBString:@"#1A1A1A"];
        _urlTextView.font = font12;
        _urlTextView.textAlignment = NSTextAlignmentLeft;
        
        _urlTextView.scrollEnabled = NO;
        _urlTextView.editable = NO;
        _urlTextView.textContainerInset = UIEdgeInsetsZero;
        _urlTextView.delegate = self;
    }
    return _urlTextView;
}

-(UIButton *)applyButton
{
    if (!_applyButton) {
        _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_applyButton addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
        _applyButton.backgroundColor = [UIColor colorWithRGBString:@"#1E86FF"];
        [_applyButton setTitle:@"确认申请" forState:UIControlStateNormal];
        [_applyButton setTitleColor:[UIColor colorWithRGBString:@"#FFFFFF"] forState:UIControlStateNormal];
        _applyButton.titleLabel.font = font16;
        _applyButton.layer.cornerRadius = GMLAYOUTRATE(45/2);
    }
    return _applyButton;
}

-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _backButton.backgroundColor = [UIColor clearColor];
        [_backButton setTitle:@"返回首页" forState:UIControlStateNormal];
        _backButton.titleLabel.font = font14;
        [_backButton setTitleColor:[UIColor colorWithRGBString:@"#1E86FF"] forState:UIControlStateNormal];
    }
    return _backButton;
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICE_HEIGHT - GMLAYOUTRATE(430), DEVICE_WIDTH, GMLAYOUTRATE(430))];
        _containerView.backgroundColor = [UIColor colorWithRGBString:@"#FFFFFF"];
    }
    return _containerView;
}

-(void)setAgreements:(NSArray<NSDictionary *> *)agreements
{
    _agreements = agreements;
    
    NSMutableArray *contractNames = [@[] mutableCopy];
    NSMutableArray *contractTypes = [@[] mutableCopy];
    //NSArray *arrayURL = @[@"quotaService",@"creditInvestigation",@"eSignAgreement",@"restSignService"];
    NSMutableArray *urls = [@[] mutableCopy];
    [agreements enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *string = @"《";
        string = [string stringByAppendingString:[obj objectForKey:@"contractName"]];
        string = [string stringByAppendingString:@"》"];
        [contractNames addObject:string];
        [contractTypes addObject:[obj objectForKey:@"contractType"]];
        NSString *urlString = [NSString stringWithFormat:@"contractType%@",[obj objectForKey:@"contractType"]];
        [urls addObject:urlString];
    }];
    NSString *linkString = [contractNames componentsJoinedByString:@""];
    self.urlTextView.text = [NSString stringWithFormat:@"点击确认申请即表示您已阅读并同意%@",linkString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_urlTextView.text];
    for (int i = 0; i < urls.count; i++) {
        [attributedString addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%@://%@",urls[i], urls[i]] range:[[attributedString string] rangeOfString:contractNames[i]]];
        [attributedString addAttribute:NSFontAttributeName value:font12 range:[[attributedString string] rangeOfString:contractNames[i]]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRGBString:@"#003800 "] range:[[attributedString string] rangeOfString:contractNames[i]]];
    }
    self.urlTextView.attributedText = attributedString;
    [self.urlTextView setLineSpace:GMLAYOUTRATE(4.0f) Attributed:attributedString Range:NSMakeRange(0, attributedString.length)];
}


@end
