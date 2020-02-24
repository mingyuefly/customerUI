//
//  PersonalInfoCell.m
//  meijie
//
//  Created by Gguomingyue on 2018/12/13.
//  Copyright © 2018 美借. All rights reserved.
//

#import "PersonalInfoCell.h"
#import "Masonry.h"
#import "GMLayoutRate.h"
#import "defines.h"
#import "UIColor+Extension.h"
#import "MJADDPlaceholderTextView.h"
#import "UITextView+Space.h"

@interface PersonalInfoCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) UIImageView *rightArrowImageView;
@property (nonatomic, strong) MJADDPlaceholderTextView *textView;

@end

@implementation PersonalInfoCell
#pragma mark - constructors
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.index = reuseIdentifier.integerValue;
        [self setupUI];
        //[self.textfield addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

+(instancetype)CellWithTableView:(UITableView *)tableView Index:(NSUInteger)index
{
    NSString *identifier = [NSString stringWithFormat:@"%lu",(unsigned long)index];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return (PersonalInfoCell *)cell;
}

#pragma mark - setup UI
-(void)setupUI
{
    if (self.index % 2 != 0) {
        //[self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.textfield];
        [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(GMLAYOUTRATE(20));
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-GMLAYOUTRATE(20));
            //make.top.equalTo(self.contentView);
            //make.size.mas_equalTo(CGSizeMake(GMLAYOUTRATE(200), GMLAYOUTRATE(GMLAYOUTRATE(15))));
        }];
    } else {
        //[self.contentView setBackgroundColor:[UIColor greenColor]];
    }
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //[self.contentView addSubview:self.textfield];
    //[self.contentView addSubview:self.rightArrowImageView];
    //[self.contentView addSubview:self.textView];
    
    [self addConstraints];
}

-(void)addConstraints
{
//    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(GMLAYOUTRATE(20));
//        make.centerY.equalTo(self.contentView);
//        make.right.equalTo(self.contentView).offset(-GMLAYOUTRATE(20));
//        //make.top.equalTo(self.contentView);
//        //make.size.mas_equalTo(CGSizeMake(GMLAYOUTRATE(200), GMLAYOUTRATE(GMLAYOUTRATE(15))));
//    }];
    
//    [self.rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView).offset(-GMLAYOUTRATE(20));
//        make.centerY.equalTo(self.contentView);
//        make.size.mas_equalTo(CGSizeMake(GMLAYOUTRATE(100), GMLAYOUTRATE(20)));
//    }];
    
//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(GMLAYOUTRATE(20));
//        make.centerY.equalTo(self.contentView);
//        make.right.equalTo(self.contentView).offset(-GMLAYOUTRATE(20));
//    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CALayer *lineLayer = [CALayer layer];
    lineLayer.backgroundColor = [UIColor blackColor].CGColor;
    lineLayer.frame = CGRectMake(20, CGRectGetMaxY(self.contentView.bounds) - 0.25f, [UIScreen mainScreen].bounds.size.width - 2 * 20, 0.5f);
    [self.contentView.layer addSublayer:lineLayer];
    
    if (self.index % 2 != 0) {
        //[self.contentView setBackgroundColor:[UIColor clearColor]];
    } else {
        [self.contentView addSubview:self.textView];
    }
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [string isEqualToString:@""]?YES:textField.text.length + (textField.text.length - range.length) <= 30;
}

#pragma mark - getters and setters
-(UITextField *)textfield
{
    if (!_textfield) {
        _textfield = [[UITextField alloc] init];
        _textfield.backgroundColor = [UIColor clearColor];
        //_textfield.backgroundColor = [UIColor redColor];
        _textfield.font = [UIFont systemFontOfSize:15];
        _textfield.textAlignment = NSTextAlignmentLeft;
        _textfield.textColor = [UIColor blackColor];
        _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        //_textfield.text = @"texttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttext";
        _textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textfield.placeholder = @"请填写公司地址";
        
        _textfield.delegate = self;
    }
    return _textfield;
}

-(MJADDPlaceholderTextView *)textView
{
    if (!_textView) {
        _textView = [[MJADDPlaceholderTextView alloc] initWithFrame:CGRectMake(GMLAYOUTRATE(16), GMLAYOUTRATE(82/2 - 80/2), DEVICE_WIDTH - 2 * GMLAYOUTRATE(16), GMLAYOUTRATE(80))];
        //_textView = [[MJADDPlaceholderTextView alloc] initWithFrame:CGRectMake(GMLAYOUTRATE(16), GMLAYOUTRATE(54/2 - 52/2), DEVICE_WIDTH - 2 * GMLAYOUTRATE(16), GMLAYOUTRATE(52))];
        //_textView.delegate = self;
        _textView.inputText = @"V爱的";
        //_textView.inputText = @"";
    }
    return _textView;
}


-(UIImageView *)rightArrowImageView
{
    if (!_rightArrowImageView) {
        _rightArrowImageView = [[UIImageView alloc] init];
        _rightArrowImageView.backgroundColor = [UIColor blueColor];
    }
    return _rightArrowImageView;
}

-(void)dealloc
{
    //[self.textfield removeObserver:self forKeyPath:@"text"];
}

@end
