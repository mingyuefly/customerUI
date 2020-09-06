//
//  ViewController.m
//  NSAutoLayout
//
//  Created by mingyue on 2020/6/26.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic , strong)UIView *redView;
@property (nonatomic , strong)UIView *yellowView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    ///先将控件添加到视图上
    [self.view addSubview:self.redView];
    [self.view addSubview:self.yellowView];
    
    ///注意translatesAutoresizingMaskIntoConstraints 一定要设置为 NO
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    self.yellowView.translatesAutoresizingMaskIntoConstraints = NO;
    
    ///创建第四个参数用到布局 views 的字典 注意 这个地方用 NSDictionaryOfVariableBindings
    NSDictionary *views  = NSDictionaryOfVariableBindings(_redView,_yellowView);
    
    ///创建第三个参数 所用到的 布局度量 metres 字典
    NSDictionary *metres = @{@"redViewnW":@100,@"leftArglin":@50,@"rightArglin":@50};
    
    ///现在开始创建约束
    
    ///水平方向的约束
    NSArray *HContrains = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftArglin-[_redView(redViewnW)]-11-[_yellowView]-rightArglin-|" options:0 metrics:metres views:views];
    
    ///垂直方向的约束
    NSArray *VContrains = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_redView(50)]-20-[_yellowView(==_redView)]" options:0 metrics:metres views:views];
    ///注意上面 如果V:|-20-[_redView(50)]-20-[_yellowView(==_redView)] 换成了V:|-20-[_redView(50)]-20-[_yellowView(==_redView)]-| 会把_yellowView拉着顶到父视图的下边,所以如果你写了这个-| 又和_yellowView 高度定死和 距离 _redView 20 起了冲突 所以会报约束异常
    
    ///添加约束
    [self.view addConstraints:HContrains];
    [self.view addConstraints:VContrains];
    
    */
    [self.view setBackgroundColor:[UIColor redColor]];
    
    //创建子view
    UIView *subView = [[UIView alloc] init];
    [subView setBackgroundColor:[UIColor blackColor]];
    //将子view添加到父视图上
    [self.view addSubview:subView];
    
    //使用Auto Layout约束，禁止将Autoresizing Mask转换为约束
    [subView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //layout 子view
    
    //子view的上边缘离父view的上边缘40个像素
    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:40.0];
    //子view的左边缘离父view的左边缘40个像素
    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:40.0];
    //子view的下边缘离父view的下边缘40个像素
    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-40.0];
    //子view的右边缘离父view的右边缘40个像素
    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-40.0];
    
    //把约束添加到父视图上
    NSArray *array = [NSArray arrayWithObjects:contraint1, contraint2, contraint3, contraint4, nil];
    [self.view addConstraints:array];
    
}

#pragma mark - 懒加载两个 view 均未设置大小
-(UIView *)redView
{
    if (!_redView) {
        _redView = [[UIView alloc]init];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}
-(UIView *)yellowView
{
    if (!_yellowView) {
        _yellowView = [[UIView alloc]init];
        _yellowView.backgroundColor = [UIColor yellowColor];
    }
    return _yellowView;
}

@end
