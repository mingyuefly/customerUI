//
//  GMActionSheetCell.m
//  LoanClient
//
//  Created by Gguomingyue on 2018/1/9.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import "GMActionSheetCell.h"
#import "UIColor+Extension.h"
#import "GMActionSheetDefines.h"
#import "GMLayoutRate.h"

@interface GMActionSheetCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation GMActionSheetCell

#pragma mark - constructed functions
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)CellWithTableView:(UITableView *)tableView
{
    NSString *identifer = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return (GMActionSheetCell *)cell;
}

#pragma mark - setup UI
-(void)setupUI
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.contentView addSubview:self.label];
    [self addConstraints];
}

-(void)addConstraints
{
    self.label.frame = self.contentView.bounds;
}

#pragma mark - getters and setters
-(UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorWithRGBString:@"#333333"];
        _label.font = font18;
    }
    return _label;
}

-(void)setModel:(GMActionSheetCellModel *)model
{
    _model = model;
    self.label.text = _model.titleString;
}

#pragma mark - layout subviews
-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    
}


@end

