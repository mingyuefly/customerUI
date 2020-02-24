//
//  ViewController.m
//  countingLabel
//
//  Created by Gguomingyue on 2019/11/7.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "MYCountingLabel.h"
#import "UICountingLabel.h"

@interface ViewController ()

@property(nonatomic, strong) MYCountingLabel *label;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) NSTimer *balanceLabelAnimationTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[self.view addSubview:self.moneyLabel];
    //[self setNumberTextOfLabel:self.moneyLabel WithAnimationForValueContent:50000.00];
    
    [self.view addSubview:self.label];
    //[self.label countFrom:10000 to:20000];
    //[self.label countTo:20100];
    //[self.label countRandomTo:20100.56];
    //[self.label countRandomTo:20100.56789];
    [self.label countRandomTo:200000];
    //[self.label countRandomTo:2010.56];
    //[self.label countRandomTo:2010];
    //[self.label countTo:10000];
    
//
//    UICountingLabel* myLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
//    myLabel.method = UILabelCountingMethodLinear;
//    myLabel.format = @"%d";
//    [self.view addSubview:myLabel];
//    [myLabel countFrom:1 to:10 withDuration:3.0];
    
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 300, 80)];
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:50];
    }
    return _moneyLabel;
}

#pragma mark --- 余额显示的动画----
- (void)setNumberTextOfLabel:(UILabel *)label WithAnimationForValueContent:(CGFloat)value
{
    CGFloat lastValue = [label.text floatValue];
    CGFloat delta = value - lastValue;
    if (delta == 0) {
        return;
    }

    if (delta > 0) {
        CGFloat ratio = value / 30.0;
        NSDictionary *userInfo = @{@"label" : label,
                                   @"value" : @(value),
                                   @"ratio" : @(ratio)
                                   };
        _balanceLabelAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(setupLabel:) userInfo:userInfo repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_balanceLabelAnimationTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)setupLabel:(NSTimer *)timer
{
    NSDictionary *userInfo = timer.userInfo;
    UILabel *label = userInfo[@"label"];
    CGFloat value = [userInfo[@"value"] floatValue];
    CGFloat ratio = [userInfo[@"ratio"] floatValue];

    static int flag = 1;
    CGFloat lastValue = [label.text floatValue];
    CGFloat randomDelta = (arc4random_uniform(2) + 1) * ratio;
    CGFloat resValue = lastValue + randomDelta;

    if ((resValue >= value) || (flag == 50)) {
        label.text = [NSString stringWithFormat:@"¥%.2f", value];
        flag = 1;
        [timer invalidate];
        timer = nil;
        return;
    } else {
        label.text = [NSString stringWithFormat:@"%.2f", resValue];
    }
    flag++;
}

-(MYCountingLabel *)label
{
    if (!_label) {
        _label = [[MYCountingLabel alloc] initWithFrame:CGRectMake(20, 150, 300, 80)];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont fontWithName:@"Arial-BoldMT" size:50];
    }
    return _label;
}


@end
