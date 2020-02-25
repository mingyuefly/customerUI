//
//  CurveView.m
//  HuangheDirectBank
//
//  Created by mingyue on 15-6-25.
//  Copyright (c) 2015年 刘旺. All rights reserved.
//

#import "CurveView.h"
#include <math.h>

static int point[7] = {0};//竖坐标位置
static int horizontalPoint[7] = {64,100,136,172,208,244,280};//横坐标位置
static int verticalSpacing = 36;//横线间距
static int horizontalSpacing = 26;//竖线间距
static int bottomLine = 126;//底线纵坐标

@interface CurveView()

{
    UIImageView* shouyilvIv1;
    NSMutableArray* tapArr;
}

@property(nonatomic,strong)UILabel* horizontalLabel0;
@property(nonatomic,strong)UILabel* horizontalLabel1;
@property(nonatomic,strong)UILabel* horizontalLabel2;
@property(nonatomic,strong)UILabel* horizontalLabel3;
@property(nonatomic,strong)UILabel* horizontalLabel4;
@property(nonatomic,strong)UILabel* horizontalLabel5;
@property(nonatomic,strong)UILabel* horizontalLabel6;

@property(nonatomic,strong)UILabel* verticalLabel0;
@property(nonatomic,strong)UILabel* verticalLabel1;
@property(nonatomic,strong)UILabel* verticalLabel2;
@property(nonatomic,strong)UILabel* verticalLabel3;
@property(nonatomic,strong)UILabel* verticalLabel4;

@property(nonatomic,strong)NSMutableArray* verticalLabelArr;

@property(nonatomic,strong)NSMutableArray* horizontalLabelArr;

@property(nonatomic,strong)NSMutableArray* rateArray;
@property(nonatomic,strong)NSMutableArray* rateIntervalArray;

@property(nonatomic,strong)NSMutableArray* dateArray;

//@property(nonatomic,strong)UIImageView* rateIv;


@end

@implementation CurveView


-(instancetype)initWithFrame:(CGRect)frame Date:(NSArray *)dateArr Rate:(NSArray *)rateArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.rateArray = [rateArr mutableCopy];
        self.dateArray = [dateArr mutableCopy];
        float minRate = [[self.rateArray objectAtIndex:0] floatValue];
        float maxRate = [[self.rateArray objectAtIndex:0] floatValue];
        for (int i = 1; i < self.rateArray.count; i++) {
            if (minRate >= [[self.rateArray objectAtIndex:i]floatValue]) {
                minRate = [[self.rateArray objectAtIndex:i]floatValue];
            }
            if (maxRate <= [[self.rateArray objectAtIndex:i] floatValue]) {
                maxRate = [[self.rateArray objectAtIndex:i] floatValue];
            }
        }
        
        float interval = (maxRate-minRate)/4;
        self.rateIntervalArray = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < 7; i++) {
            //if (i == 0) {
            //point[i] = 126;
            //}else if (i == 6){
            //point[i] = 22;
            //}else{
            point[i] = 22 + 104 * (maxRate - [[self.rateArray objectAtIndex:i]floatValue])/(maxRate - minRate);
            //}
        }
        
        for (int i = 0; i < 4; i++) {
            [self.rateIntervalArray addObject:@(minRate + i*interval)];
        }
        [self.rateIntervalArray addObject:@(maxRate)];
        
        self.verticalLabelArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < 5; i++) {
            UILabel* label = [[UILabel alloc]init];
            label.frame = CGRectMake(18, 12+horizontalSpacing*i, 30, 16);
            //label.backgroundColor = [UIColor greenColor];
            label.tag = i+20;
            [self addSubview:label];
            label.text = @"5.009";
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:9];
            label.textColor = [UIColor colorWithRed:135/255.0 green:132/255.0 blue:133/255.0 alpha:1.0];
            [self.verticalLabelArr addObject:label];
        }
        
        self.horizontalLabelArr = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < 7; i++) {
            UILabel* label = [[UILabel alloc]init];
            label.frame = CGRectMake(49+verticalSpacing*i, 130, 30, 16);
            //label.backgroundColor = [UIColor greenColor];
            label.tag = i+30;
            [self addSubview:label];
            label.text = @"05-01";
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:9];
            label.textColor = [UIColor colorWithRed:135/255.0 green:132/255.0 blue:133/255.0 alpha:1.0];
            [self.horizontalLabelArr addObject:label];
        }
        

        
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //4横7竖
    for (int i = 0; i < 4; i++) {
        CGContextMoveToPoint(context, 0+46, horizontalSpacing*i+48);
        CGContextAddLineToPoint(context, 300, horizontalSpacing*i+48);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0].CGColor);
        //CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetLineWidth(context, 0.1);
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0].CGColor);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    for (int i = 0; i < 7; i++) {
        CGContextMoveToPoint(context, verticalSpacing*i+64, 0+20);
        CGContextAddLineToPoint(context, verticalSpacing*i+64, bottomLine);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0].CGColor);
        CGContextSetLineWidth(context, 0.1);
        //CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0xD6/255.0 green:0xD6/255.0 blue:0xD6/255.0 alpha:1.0].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0].CGColor);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    
    //加阴影
    for (int k = 0; k < 6; k++) {
        int a = abs(point[k] - point[k+1]);
        if (a == 0) {
            
        } else {
            for (int i = 0; i <= a; i++) {
                for (int j = 0; j <= verticalSpacing*i/a; j++) {
                    UIView * view = [[UIView alloc]init];
                    if (point[k]<point[k+1]) {
                        view.frame = CGRectMake(horizontalPoint[k]+j, point[k]+i, 1, 1);
                    }else{
                        view.frame = CGRectMake(horizontalPoint[k+1]-j, point[k+1]+i, 1, 1);
                    }
                    
                    //view.backgroundColor = [UIColor redColor];
                    view.alpha = 0.6;
                    view.backgroundColor = [UIColor colorWithRed:0xFF/255.0 green:0xF7/255.0 blue:0xE7/255.0 alpha:1.0];
                    [self addSubview:view];
                }
            }
        }
        
        int b = point[k] < point[k+1]?(bottomLine - point[k+1]):(bottomLine - point[k]);
        for (int i = 1; i <= b; i++) {
            for (int j = 0; j <= verticalSpacing; j++) {
                UIView* view = [[UIView alloc]init];
                if (point[k] < point[k+1]) {
                    view.frame = CGRectMake(horizontalPoint[k]+j, point[k+1]+i, 1, 1);
                }else{
                    view.frame = CGRectMake(horizontalPoint[k]+j, point[k]+i, 1, 1);
                }
                
                //view.backgroundColor = [UIColor redColor];
                view.alpha = 0.6;
                view.backgroundColor = [UIColor colorWithRed:0xFF/255.0 green:0xF7/255.0 blue:0xE7/255.0 alpha:1.0];
                [self addSubview:view];
            }
        }

        
    }
    
    //折线
    CGContextMoveToPoint(context, 64, point[0]);
    for (int i = 0; i < 6; i++) {
        CGContextAddLineToPoint(context, horizontalPoint[i+1], point[i+1]);
    }
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:207/255.0 green:207/255.0 blue:202/255.0 alpha:1.0].CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextDrawPath(context, kCGPathStroke);
    
    //将圆点置于角点
    tapArr = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        UIImageView* iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        iv.center = CGPointMake(horizontalPoint[i], point[i]);
        iv.tag = i;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shouyilvAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [iv addGestureRecognizer:tap];
        [tapArr addObject:tap];
        iv.userInteractionEnabled = YES;
        if (i == 0 || i == 6) {
            iv.image = [UIImage imageNamed:@"hongdian.png"];
        }else{
            iv.image = [UIImage imageNamed:@"hongquan.png"];
        }
        [self addSubview:iv];
        [self bringSubviewToFront:iv];
    }
    
    [self shouyilvAction:tapArr[2]];
}

-(void)layoutSubviews{
    NSLog(@"self.rateIntervalArray----->>>>>>%@",self.rateIntervalArray);
    for (int i = 0; i < self.verticalLabelArr.count; i++) {
        UILabel* lable = [self.verticalLabelArr objectAtIndex:i];
        switch (lable.tag) {
            case 20:
                lable.text = [NSString stringWithFormat:@"%.3f",[[self.rateIntervalArray objectAtIndex:4] floatValue]];
                break;
            case 21:
                lable.text = [NSString stringWithFormat:@"%.3f",[[self.rateIntervalArray objectAtIndex:3] floatValue]];
                break;
            case 22:
                lable.text = [NSString stringWithFormat:@"%.3f",[[self.rateIntervalArray objectAtIndex:2] floatValue]];
                break;
            case 23:
                lable.text = [NSString stringWithFormat:@"%.3f",[[self.rateIntervalArray objectAtIndex:1] floatValue]];
                break;
            case 24:
                lable.text = [NSString stringWithFormat:@"%.3f",[[self.rateIntervalArray objectAtIndex:0] floatValue]];
                break;
            default:
                break;
        }
    }
    
    for (int i = 0; i < self.horizontalLabelArr.count; i++) {
        UILabel* lable = [self.horizontalLabelArr objectAtIndex:i];
        switch (lable.tag) {
            case 30:
                lable.text = [NSString stringWithFormat:@"%@",[self.dateArray objectAtIndex:0]];
                break;
            case 31:
                lable.text = [NSString stringWithFormat:@"%@",[self.dateArray objectAtIndex:1]];
                break;
            case 32:
                lable.text = [NSString stringWithFormat:@"%@",[self.dateArray objectAtIndex:2]];
                break;
            case 33:
                lable.text = [NSString stringWithFormat:@"%@",[self.dateArray objectAtIndex:3]];
                break;
            case 34:
                lable.text = [NSString stringWithFormat:@"%@",[self.dateArray objectAtIndex:4]];
                break;
            case 35:
                lable.text = [NSString stringWithFormat:@"%@",[self.dateArray objectAtIndex:5]];
                break;
            case 36:
                lable.text = [NSString stringWithFormat:@"%@",[self.dateArray objectAtIndex:6]];
                break;
            default:
                break;
        }
    }
    
    
}

-(void)shouyilvAction:(UITapGestureRecognizer*)sender{
    
    if (shouyilvIv1) {
        [shouyilvIv1 removeFromSuperview];
        shouyilvIv1 = nil;
    }
    
    //收益率图
    long int index = sender.view.tag;
    int x = horizontalPoint[index];
    int y = point[index];
    
    shouyilvIv1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 43, 26)];
    shouyilvIv1.center = CGPointMake(x, y-20);
    shouyilvIv1.image = [UIImage imageNamed:@"shouyilv.png"];
    [self addSubview:shouyilvIv1];
    UILabel* shouyilvLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 36, 20)];
    shouyilvLabel1.center = CGPointMake(21.5, 10);
    shouyilvLabel1.textAlignment = NSTextAlignmentCenter;
    shouyilvLabel1.textColor = [UIColor colorWithRed:0xFF/255.0 green:0xFF/255.0 blue:0xFF/255.0 alpha:1.0];
    shouyilvLabel1.backgroundColor = [UIColor clearColor];
    shouyilvLabel1.font = [UIFont systemFontOfSize:12];
    shouyilvLabel1.text = [self.rateArray objectAtIndex:index];
    [shouyilvIv1 addSubview:shouyilvLabel1];

}


@end
