//
//  MYCountingLabel.m
//  countingLabel
//
//  Created by Gguomingyue on 2019/11/7.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "MYCountingLabel.h"

typedef NS_ENUM(NSInteger, CountType){
    CountTypeAdd   = 0,
    CountTypeRadom = 1
};

@interface MYCountingLabel ()

//@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat fromValue;
@property (nonatomic, assign) CGFloat toValue;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) CGFloat timeDistance;
@property (nonatomic, assign) CGFloat currentValue;
@property (nonatomic, strong) NSNumberFormatter *formatter;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *digitalsArray;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *floatDigitalsArray;
@property (nonatomic, assign) CountType countType;

@end

@implementation MYCountingLabel

#pragma mark - constructor
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.timeDistance = 2.0f;
        [self setupUI];
    }
    return self;
}

#pragma mark - setup UI
-(void)setupUI
{
    
}

#pragma mark - functions
-(void)countFrom:(CGFloat)fromValue to:(CGFloat)toValue
{
    if (self.toValue < self.fromValue) {
        self.text = [NSString stringWithFormat:@"%.2f", self.toValue];
        return;
    }
    self.fromValue = fromValue;
    self.toValue = toValue;
    self.distance = (self.toValue - self.fromValue)/(self.timeDistance * 60);
    self.text = [NSString stringWithFormat:@"%.2f", self.fromValue];
}

-(void)countFrom:(CGFloat)fromValue to:(CGFloat)toValue duration:(CGFloat)duration
{
    if (self.toValue < self.fromValue) {
        self.text = [NSString stringWithFormat:@"%.2f", self.toValue];
        return;
    }
    self.fromValue = fromValue;
    self.toValue = toValue;
    self.distance = duration;
    self.distance = (self.toValue - self.fromValue)/(self.timeDistance * 60);
    self.text = [NSString stringWithFormat:@"%.2f", self.fromValue];
}

-(void)countTo:(CGFloat)toValue
{
    self.toValue = toValue;
    if (self.fromValue == 0) {
        self.fromValue = [self getBeginValue:toValue];
    }
    self.distance = self.toValue - self.fromValue;
    if (self.distance == 0) {
        self.distance = self.toValue;
    }
    CGFloat ratio = self.distance / 30;
    NSDictionary *userInfo = @{@"ratio":@(ratio)};
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(timerAction:) userInfo:userInfo repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)countRandomTo:(CGFloat)toValue
{
    self.countType = CountTypeRadom;
    self.toValue = toValue;
    NSString *valueString = [NSString stringWithFormat:@"%.2f", toValue];
    CGFloat tempToValue = valueString.floatValue;
    [self getDigitals:tempToValue];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:UITrackingRunLoopMode];
}

-(void)countTo:(CGFloat)toValue duration:(CGFloat)duration
{
    
}

-(CGFloat)getBeginValue:(CGFloat)toValue
{
    NSInteger digitalNum = 0;
    NSInteger temp = floor(toValue);
    while (temp > 0) {
        temp = temp / 10;
        digitalNum++;
    }
    CGFloat fromValue = pow(10, digitalNum - 1);
    //self.fromValue = fromValue;
    return fromValue;
}

-(void)getDigitals:(CGFloat)toValue
{
    [self.digitalsArray removeAllObjects];
    [self.floatDigitalsArray removeAllObjects];
    NSInteger temp = floor(toValue);
    NSLog(@"%ld", (long)temp);
    while (true) {
        if (temp / 10 != 0 || temp % 10 != 0) {
            NSInteger digital = temp % 10;
            [self.digitalsArray addObject:@(digital)];
            temp = temp / 10;
        } else {
            break;
        }
    }
    self.digitalsArray = [[[self.digitalsArray reverseObjectEnumerator] allObjects] mutableCopy];
    CGFloat floatValue = toValue - floor(toValue);
    NSInteger tempF = floor(floatValue * 100);
    if (tempF == 0) {
        return;
    }
    NSLog(@"%ld", (long)tempF);
    while (true) {
        if (tempF / 10 != 0 || tempF % 10 != 0) {
            NSInteger digital = tempF % 10;
            [self.floatDigitalsArray addObject:@(digital)];
            tempF = tempF / 10;
        } else {
            break;
        }
    }
    self.floatDigitalsArray = [[[self.floatDigitalsArray reverseObjectEnumerator] allObjects] mutableCopy];
}

#pragma mark - actions
-(void)timerAction:(NSTimer *)sender
{
    if (self.countType == CountTypeAdd) {
        [self addAction:sender];
    } else {
        [self randomAction];
    }
}

-(void)addAction:(NSTimer *)sender
{
    NSLog(@"timerAction %.02f", self.fromValue);
    CGFloat ratio = [sender.userInfo[@"ratio"] floatValue];
    self.currentValue = self.fromValue + (arc4random_uniform(2) + 1) * ratio;
    static int flag = 0;
    if (self.currentValue >= self.toValue || flag == 50) {
        self.text = [self.formatter stringFromNumber:@(self.toValue)];
        [self.timer invalidate];
        flag = 0;
    } else {
        self.text = [self.formatter stringFromNumber:@(self.currentValue)];
    }
    flag++;
}

-(void)randomAction
{
    if (self.floatDigitalsArray.count > 0) {
        [self.formatter setPositiveFormat:@"###,###,##0.00;"];
    } else {
        [self.formatter setPositiveFormat:@"###,###,##0;"];
    }
    static int flag = 0;
    if (flag == 25) {
        if (self.floatDigitalsArray.count > 0) {
            self.text = [self.formatter stringFromNumber:@(self.toValue)];
        } else {
            self.text = [self.formatter stringFromNumber:@(self.toValue)];
        }
        [self.timer invalidate];
        flag = 0;
    } else {
        NSInteger count = self.digitalsArray.count;
        for (int i = 0; i < count; i++) {
            NSInteger digital = [[self.digitalsArray objectAtIndex:i] integerValue];
            digital++;
            if (digital > 9) {
                digital = 1;
            }
            self.digitalsArray[i] = @(digital);
        }
        NSString *intString = [self.digitalsArray componentsJoinedByString:@""];
        NSInteger floatCount = self.floatDigitalsArray.count;
        for (int i = 0; i < floatCount; i++) {
            NSInteger digital = [[self.floatDigitalsArray objectAtIndex:i] integerValue];
            digital++;
            if (digital > 9) {
                digital = 1;
            }
            self.floatDigitalsArray[i] = @(digital);
        }
        NSString *floatString = [self.floatDigitalsArray componentsJoinedByString:@""];
        NSString *currentString = @"";
        if (self.floatDigitalsArray.count > 0) {
            currentString = [NSString stringWithFormat:@"%@.%@", intString, floatString];
            self.text = [self.formatter stringFromNumber:@(currentString.floatValue)];
        } else {
            currentString = intString;
            self.text = [self.formatter stringFromNumber:@(currentString.floatValue)];;
        }
    }
    flag++;
}

#pragma mark - property
-(NSNumberFormatter *)formatter
{
    if (!_formatter) {
        _formatter = [[NSNumberFormatter alloc] init];
    }
    return _formatter;
}

-(NSMutableArray<NSNumber *> *)digitalsArray
{
    if (!_digitalsArray) {
        _digitalsArray = [@[] mutableCopy];
    }
    return _digitalsArray;
}

-(NSMutableArray<NSNumber *> *)floatDigitalsArray
{
    if (!_floatDigitalsArray) {
        _floatDigitalsArray = [@[] mutableCopy];
    }
    return _floatDigitalsArray;
}

-(void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
