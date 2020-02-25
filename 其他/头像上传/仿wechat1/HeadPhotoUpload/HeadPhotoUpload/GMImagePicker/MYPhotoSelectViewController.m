//
//  MYPhotoSelectViewController.m
//  HeadPhotoUpload
//
//  Created by Gguomingyue on 2018/1/26.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import "MYPhotoSelectViewController.h"
#import <math.h>

typedef NS_ENUM(NSInteger, SelectTouchType){
    Default        = 0,   // 中间区域
    LeftUpSquare   = 1,   // 左上角区域
    RightUpSquare  = 2,   // 右上角区域
    LeftDownSquare = 3,   // 左下角区域
    RightDownSquare = 4,   // 右下角区域
    LeftLine       = 5,   // 左边线区域
    RightLine      = 6,   // 右边线区域
    UpLine         = 7,   // 上边线区域
    DownLine       = 8,   // 下边线区域
    OutSquare      = 9    // 外边区域
};

static CGFloat smallLength = 80.0f;
static CGFloat selectRegionLength = 30.0f;

@interface MYPhotoSelectViewController ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *squareView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) UIImageView *clipImageView;
@property (nonatomic, strong) UIImage *clipImage;
@property (nonatomic, assign) CGRect cropFrame;
@property (nonatomic, assign) CGRect oldFrame;
@property (nonatomic, assign) CGRect lastFrame;
@property (nonatomic, assign) CGRect largeFrame;
@property (nonatomic, assign) NSInteger limitRatio;
@property (nonatomic, assign) BOOL bigHeight;

@property (nonatomic, assign) SelectTouchType selectTouchType;
@property (nonatomic, assign) CGMutablePathRef path1;//right line
@property (nonatomic, assign) CGMutablePathRef path2;//down line
@property (nonatomic, assign) CGMutablePathRef path3;//left line
@property (nonatomic, assign) CGMutablePathRef path4;//up line
@property (nonatomic, assign) CGMutablePathRef path5;//right up square
@property (nonatomic, assign) CGMutablePathRef path6;//right down square
@property (nonatomic, assign) CGMutablePathRef path7;//left down square
@property (nonatomic, assign) CGMutablePathRef path8;//left up square
@property (nonatomic, assign) CGMutablePathRef path0;//inside
@property (nonatomic, assign) CGMutablePathRef path10;//outside
@property (nonatomic, assign) CGPoint beginPoint;

@property (nonatomic, strong) UIView *buttonContainerView;
@property (nonatomic, strong) UIButton *conformButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation MYPhotoSelectViewController

#pragma mark - constructed functions
-(instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.originalImage = image;
    }
    return self;
}

#pragma mark - getters and setters
-(UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.frame = self.cropFrame;
        _backgroundView.layer.borderColor = [UIColor whiteColor].CGColor;
        _backgroundView.layer.borderWidth = 1.0f;
    }
    return _backgroundView;
}

-(UIView *)squareView
{
    if (!_squareView) {
        _squareView = [[UIView alloc] init];
        if (self.bigHeight) {
            _squareView.frame = self.oldFrame;
        } else {
            _squareView.frame = CGRectMake(self.cropFrame.origin.x, self.oldFrame.origin.y, self.cropFrame.size.width, self.oldFrame.size.height);
        }
        _squareView.layer.borderColor = [UIColor yellowColor].CGColor;
        _squareView.layer.borderWidth = 1.0f;
    }
    return _squareView;
}

-(CGRect)cropFrame
{
    return CGRectMake(30, self.view.center.y - ([UIScreen mainScreen].bounds.size.width - 2 * 30)/2, [UIScreen mainScreen].bounds.size.width - 2 * 30, [UIScreen mainScreen].bounds.size.width - 2 * 30);
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 0, 320, 240);
        [_imageView setMultipleTouchEnabled:YES];
        [_imageView setUserInteractionEnabled:YES];
        _imageView.image = self.originalImage;
        
        // scale to fit the screen
        CGRect screenFrame = self.view.frame;
        CGFloat screenWidth = screenFrame.size.width;
        if (self.originalImage.size.height > self.originalImage.size.width) {
            self.bigHeight = YES;
        } else {
            self.bigHeight = NO;
        }
        if (self.bigHeight) {
            CGFloat oriWidth = self.cropFrame.size.width;
            CGFloat oriHeight = self.originalImage.size.height * (oriWidth/self.originalImage.size.width);
            CGFloat oriX = self.cropFrame.origin.x;
            CGFloat oriY = self.cropFrame.origin.y + self.cropFrame.size.height/2 - oriHeight/2;
            self.oldFrame = CGRectMake(oriX, oriY, oriWidth, oriHeight);
            self.lastFrame = self.oldFrame;
            _imageView.frame = self.oldFrame;
            self.largeFrame = CGRectMake(0, 0, self.limitRatio * self.oldFrame.size.width, self.limitRatio * self.oldFrame.size.height);
        } else {
            CGFloat oriWidth = screenWidth;
            CGFloat oriHeight = self.originalImage.size.height * (oriWidth/self.originalImage.size.width);
            CGFloat oriX = 0;
            CGFloat oriY = self.cropFrame.origin.y + self.cropFrame.size.height/2 - oriHeight/2;
            self.oldFrame = CGRectMake(oriX, oriY, oriWidth, oriHeight);
            self.lastFrame = self.oldFrame;
            _imageView.frame = self.oldFrame;
            self.largeFrame = CGRectMake(0, 0, self.limitRatio * self.oldFrame.size.width, self.limitRatio * self.oldFrame.size.height);
        }
    }
    return _imageView;
}

-(UIView *)buttonContainerView
{
    if (!_buttonContainerView) {
        _buttonContainerView = [[UIView alloc] init];
        _buttonContainerView.frame = CGRectMake(0, self.view.frame.size.height - 70.0f, self.view.frame.size.width, 70.0f);
        _buttonContainerView.backgroundColor = [UIColor colorWithRed:40/255.f green:40/255.f blue:40/255.f alpha:0.8];
    }
    return _buttonContainerView;
}

-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, 10, 100, 50);
        _cancelButton.backgroundColor = [UIColor clearColor];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [_cancelButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_cancelButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_cancelButton.titleLabel setNumberOfLines:0];
        [_cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(UIButton *)conformButton
{
    if (!_conformButton) {
        _conformButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _conformButton.frame = CGRectMake(self.view.frame.size.width - 100.0f, 10, 100, 50);
        _conformButton.backgroundColor = [UIColor clearColor];
        [_conformButton setTitle:@"选取" forState:UIControlStateNormal];
        [_conformButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [_conformButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_conformButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_conformButton.titleLabel setNumberOfLines:0];
        [_conformButton setTitleEdgeInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
        [_conformButton addTarget:self action:@selector(conformAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conformButton;
}

-(UIImageView *)clipImageView
{
    if (!_clipImageView) {
        _clipImageView = [[UIImageView alloc] initWithFrame:self.cropFrame];
    }
    return _clipImageView;
}

// special region 0 center
-(CGMutablePathRef)path0
{
    CGMutablePathRef path0 = CGPathCreateMutable();
    CGPathMoveToPoint(path0, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path0, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path0, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path0, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path0, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathCloseSubpath(path0);
    return path0;
}

// special region 1 right
-(CGMutablePathRef)path1
{
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathMoveToPoint(path1, nil, CGRectGetMaxX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path1, nil, CGRectGetMaxX(self.squareView.frame) + selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path1, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path1, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path1, nil, CGRectGetMaxX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) - selectRegionLength);
    CGPathCloseSubpath(path1);
    return path1;
}

// special region 2 down
-(CGMutablePathRef)path2
{
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path2, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path2, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMaxY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path2, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMaxY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path2, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathCloseSubpath(path2);
    return path2;
}

// special region 3 left
-(CGMutablePathRef)path3
{
    CGMutablePathRef path3 = CGPathCreateMutable();
    CGPathMoveToPoint(path3, nil, CGRectGetMinX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path3, nil, CGRectGetMinX(self.squareView.frame) - selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path3, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path3, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path3, nil, CGRectGetMinX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathCloseSubpath(path3);
    return path3;
}

// special region 4 up
-(CGMutablePathRef)path4
{
    CGMutablePathRef path4 = CGPathCreateMutable();
    CGPathMoveToPoint(path4, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path4, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path4, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path4, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path4, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) - selectRegionLength);
    CGPathCloseSubpath(path4);
    return path4;
}

//special region 5 right up
-(CGMutablePathRef)path5
{
    CGMutablePathRef path5 = CGPathCreateMutable();
    CGPathMoveToPoint(path5, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path5, nil, CGRectGetMaxX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path5, nil, CGRectGetMaxX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path5, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path5, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) - selectRegionLength);
    CGPathCloseSubpath(path5);
    return path5;
}

//special region 6 right down
-(CGMutablePathRef)path6
{
    CGMutablePathRef path6 = CGPathCreateMutable();
    CGPathMoveToPoint(path6, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path6, nil, CGRectGetMaxX(self.squareView.frame) + selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path6, nil, CGRectGetMaxX(self.squareView.frame) + selectRegionLength, CGRectGetMaxY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path6, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMaxY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path6, nil, CGRectGetMaxX(self.squareView.frame) - selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathCloseSubpath(path6);
    return path6;
}

//special region 7 left down
-(CGMutablePathRef)path7
{
    CGMutablePathRef path7 = CGPathCreateMutable();
    CGPathMoveToPoint(path7, nil, CGRectGetMinX(self.squareView.frame) - selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path7, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path7, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMaxY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path7, nil, CGRectGetMinX(self.squareView.frame) - selectRegionLength, CGRectGetMaxY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path7, nil, CGRectGetMinX(self.squareView.frame) - selectRegionLength, CGRectGetMaxY(self.squareView.frame) - selectRegionLength);
    CGPathCloseSubpath(path7);
    return path7;
}

//special region 8 left up
-(CGMutablePathRef)path8
{
    CGMutablePathRef path8 = CGPathCreateMutable();
    CGPathMoveToPoint(path8, nil, CGRectGetMinX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path8, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) - selectRegionLength);
    CGPathAddLineToPoint(path8, nil, CGRectGetMinX(self.squareView.frame) + selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path8, nil, CGRectGetMinX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) + selectRegionLength);
    CGPathAddLineToPoint(path8, nil, CGRectGetMinX(self.squareView.frame) - selectRegionLength, CGRectGetMinY(self.squareView.frame) - selectRegionLength);
    CGPathCloseSubpath(path8);
    return path8;
}

#pragma mark - root view life time
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupView];
}

#pragma mark - setup View
-(void)setupView
{
    [self initSubView];
    [self initControlButton];
    [self addGestureRecognizer];
}

-(void)initSubView
{
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.squareView];
    
    // update subView
    [self updateSubView];
}

-(void)updateSubView
{
    CGRect newRect = CGRectZero;
    if (self.bigHeight) {
        newRect = self.lastFrame;
    } else {
        CGFloat newHeight = self.cropFrame.size.height;
        CGFloat newWidth = self.lastFrame.size.width * (newHeight/self.lastFrame.size.height);
        newRect = CGRectMake(self.view.frame.size.width/2 - newWidth/2, self.cropFrame.origin.y, newWidth, newHeight);
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.frame = newRect;
        self.squareView.frame = self.cropFrame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.alpha = 0.2;
        }];
    }];
    
    // 点亮要裁剪的图片
    [self illumeClipPicture];
}

-(void)illumeClipPicture
{
    [self.view addSubview:self.clipImageView];
    self.clipImage = [self getSubImage];
    self.clipImageView.image = self.clipImage;
    [self.view bringSubviewToFront:self.squareView];
}

-(void)clearClipPicture
{
    [self.clipImageView removeFromSuperview];
    self.clipImage = nil;
    self.imageView.alpha = 1.0f;
}

-(void)initControlButton
{
    [self.view addSubview:self.buttonContainerView];
    [self.buttonContainerView addSubview:self.cancelButton];
    [self.buttonContainerView addSubview:self.conformButton];
}

-(void)addGestureRecognizer
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchViewAction:)];
    [self.view addGestureRecognizer:pinch];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panViewAction:)];
    [self.view addGestureRecognizer:pan];
}

#pragma mark - touch actions
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self moveTouchBegin:touches];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self moveTouch:touches];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self moveTouchEnd];
}

#pragma mark - move touch begin
-(void)moveTouchBegin:(NSSet<UITouch *> *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    if (CGPathContainsPoint(self.path1, nil, point, NO)) {
        NSLog(@"point in path1");
        self.selectTouchType = RightLine;
    } else if (CGPathContainsPoint(self.path2, nil, point, NO)) {
        NSLog(@"point in path2");
        self.selectTouchType = DownLine;
    } else if (CGPathContainsPoint(self.path3, nil, point, NO)) {
        NSLog(@"point in path3");
        self.selectTouchType = LeftLine;
    } else if (CGPathContainsPoint(self.path4, nil, point, NO)) {
        NSLog(@"point in path4");
        self.selectTouchType = UpLine;
    } else if (CGPathContainsPoint(self.path5, nil, point, NO)) {
        NSLog(@"point in path5");
        self.selectTouchType = RightUpSquare;
    } else if (CGPathContainsPoint(self.path6, nil, point, NO)) {
        NSLog(@"point in path6");
        self.selectTouchType = RightDownSquare;
    } else if (CGPathContainsPoint(self.path7, nil, point, NO)) {
        NSLog(@"point in path7");
        self.selectTouchType = LeftDownSquare;
    } else if (CGPathContainsPoint(self.path8, nil, point, NO)) {
        NSLog(@"point in path8");
        self.selectTouchType = LeftUpSquare;
    } else if (CGPathContainsPoint(self.path0, nil, point, NO)) {
        NSLog(@"point in path0");
        self.selectTouchType = Default;
        self.beginPoint = point;
    } else {
        NSLog(@"point is outside");
        self.selectTouchType = OutSquare;
    }
}

#pragma mark - move touch end
-(void)moveTouchEnd
{
    if (self.selectTouchType == OutSquare) {
        return;
    }
    if (self.selectTouchType == Default) {
        self.beginPoint = CGPointZero;
        CGRect frame = [self handleBorderOverflow:self.imageView.frame];
        [UIView animateWithDuration:0.5 animations:^{
            self.squareView.frame = self.cropFrame;
            self.imageView.frame = frame;
            self.lastFrame = frame;
        } completion:^(BOOL finished) {
            self.imageView.alpha = 0.2;
            // 点亮要裁剪的图片
            [self illumeClipPicture];
        }];
    } else {
        // 图像与选择框等比例缩放并位移
        CGFloat scaleRatio = self.squareView.frame.size.width/self.cropFrame.size.width;
        CGFloat newWidth = self.imageView.frame.size.width/scaleRatio;
        CGFloat newHeight = self.imageView.frame.size.height/scaleRatio;
        // 最终选择框中心点
        CGPoint oldCenter = CGPointMake(self.squareView.frame.origin.x + self.squareView.frame.size.width/2, self.squareView.frame.origin.y + self.squareView.frame.size.height/2);
        // cropFrame 中心点
        CGPoint cropCenter = CGPointMake(self.cropFrame.origin.x + self.cropFrame.size.width/2, self.cropFrame.origin.y + self.cropFrame.size.height/2);
        // 移动距离
        CGFloat distanceX = cropCenter.x - oldCenter.x;
        CGFloat distanceY = cropCenter.y - oldCenter.y;
        CGRect imageViewFrame = self.imageView.frame;
        CGFloat middleX = imageViewFrame.origin.x + distanceX;
        CGFloat middleY = imageViewFrame.origin.y + distanceY;
        //CGRect middleFrame = CGRectMake(middleX, middleY, imageViewFrame.size.width, imageViewFrame.size.height);
        // 等比例放大
        CGFloat middleDistanceXAndDatumX = self.cropFrame.origin.x + self.cropFrame.size.width/2 - middleX;
        CGFloat middleDistanceYAndDatumY = self.cropFrame.origin.y + self.cropFrame.size.height/2 - middleY;
        CGFloat newX = self.cropFrame.origin.x + self.cropFrame.size.width/2 - middleDistanceXAndDatumX/scaleRatio;
        CGFloat newY = self.cropFrame.origin.y + self.cropFrame.size.height/2 - middleDistanceYAndDatumY/scaleRatio;
        CGRect newFrame = CGRectMake(newX, newY, newWidth, newHeight);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                self.squareView.frame = self.cropFrame;
                self.imageView.frame = newFrame;
                self.lastFrame = newFrame;
            } completion:^(BOOL finished) {
                self.imageView.alpha = 0.2;
                // 点亮要裁剪的图片
                [self illumeClipPicture];
            }];
        });
    }
}

-(CGRect)handleBorderOverflow:(CGRect)newFrame;
{
    // horizontally
    if (newFrame.origin.x > self.cropFrame.origin.x) {
        // 图片偏右，将其左侧和crop左侧对齐
        newFrame.origin.x = self.cropFrame.origin.x;
    }
    if (CGRectGetMaxX(newFrame) < self.cropFrame.size.width) {
        // 图片偏左，将其右侧和crop的右侧对齐
        newFrame.origin.x = self.cropFrame.origin.x + self.cropFrame.size.width - newFrame.size.width;
    }
    // vertically
    if (newFrame.origin.y > self.cropFrame.origin.y) {
        // 偏下
        newFrame.origin.y = self.cropFrame.origin.y;
    }
    if (CGRectGetMaxY(newFrame) < self.cropFrame.origin.y + self.cropFrame.size.height) {
        // 偏上
        newFrame.origin.y = self.cropFrame.origin.y + self.cropFrame.size.height - newFrame.size.height;
    }
    // adapt horizontally rectangle
    if (self.imageView.frame.size.width > self.imageView.frame.size.height && newFrame.size.height <= self.cropFrame.size.height) {
        // 如果图片高度小于crop高度，垂直居中
        newFrame.origin.y = self.cropFrame.origin.y + (self.cropFrame.size.height - newFrame.size.height)/2;
    }
    return newFrame;
}

#pragma mark - move touch
-(void)moveTouch:(NSSet<UITouch *> *)touches
{
    if (self.selectTouchType == OutSquare) {
        return;
    }
    [self clearClipPicture];
    switch (self.selectTouchType) {
        case RightLine:
        {
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:self.view];
            CGRect backgroundFrame = self.backgroundView.frame;
            if (point.x > backgroundFrame.origin.x + backgroundFrame.size.width) {
                self.squareView.frame = backgroundFrame;
            } else if (point.x < backgroundFrame.origin.x + smallLength) {
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + smallLength/2, backgroundFrame.origin.y + backgroundFrame.size.height/2);
                CGRect newFrame = CGRectMake(0, 0, smallLength, smallLength);
                self.squareView.frame = newFrame;
                self.squareView.center = newCenter;
            } else {
                CGFloat newWidth = point.x - backgroundFrame.origin.x;
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + newWidth/2, self.backgroundView.center.y);
                CGRect newFrame = CGRectMake(0, 0, newWidth, newWidth);
                [UIView animateWithDuration:0.1 animations:^{
                    self.squareView.frame = newFrame;
                    self.squareView.center = newCenter;
                }];
            }
        }
            break;
        case DownLine:
        {
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:self.view];
            CGRect backgroundFrame = self.backgroundView.frame;
            if (point.y > backgroundFrame.origin.y + backgroundFrame.size.height) {
                self.squareView.frame = backgroundFrame;
            } else if (point.y < backgroundFrame.origin.y + smallLength) {
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + backgroundFrame.size.width/2, backgroundFrame.origin.y + smallLength/2);
                CGRect newFrame = CGRectMake(0, 0, smallLength, smallLength);
                self.squareView.frame = newFrame;
                self.squareView.center = newCenter;
            } else {
                CGFloat newHeight = point.y - backgroundFrame.origin.y;
                CGPoint newCenter = CGPointMake(self.backgroundView.center.x, backgroundFrame.origin.y + newHeight/2);
                CGRect newFrame = CGRectMake(0, 0, newHeight, newHeight);
                [UIView animateWithDuration:0.1 animations:^{
                    self.squareView.frame = newFrame;
                    self.squareView.center = newCenter;
                }];
            }
        }
            break;
        case LeftLine:
        {
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:self.view];
            CGRect backgroundFrame = self.backgroundView.frame;
            if (point.x < backgroundFrame.origin.x) {
                self.squareView.frame = backgroundFrame;
            } else if (point.x > backgroundFrame.origin.x + backgroundFrame.size.width - smallLength) {
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + backgroundFrame.size.width - smallLength/2, backgroundFrame.origin.y + backgroundFrame.size.height/2);
                CGRect newFrame = CGRectMake(0, 0, smallLength, smallLength);
                self.squareView.frame = newFrame;
                self.squareView.center = newCenter;
            } else {
                CGFloat newWidth = backgroundFrame.origin.x + backgroundFrame.size.width - point.x;
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + backgroundFrame.size.width - newWidth/2, self.backgroundView.center.y);
                CGRect newFrame = CGRectMake(0, 0, newWidth, newWidth);
                [UIView animateWithDuration:0.1 animations:^{
                    self.squareView.frame = newFrame;
                    self.squareView.center = newCenter;
                }];
            }
        }
            break;
        case UpLine:
        {
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:self.view];
            CGRect backgroundFrame = self.backgroundView.frame;
            if (point.y < backgroundFrame.origin.y) {
                self.squareView.frame = backgroundFrame;
            } else if (point.y > backgroundFrame.origin.y + backgroundFrame.size.height - smallLength) {
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + backgroundFrame.size.width/2, backgroundFrame.origin.y + backgroundFrame.size.height - smallLength/2);
                CGRect newFrame = CGRectMake(0, 0, smallLength, smallLength);
                self.squareView.frame = newFrame;
                self.squareView.center = newCenter;
            } else {
                CGFloat newHeight = backgroundFrame.origin.y + backgroundFrame.size.height - point.y;
                CGPoint newCenter = CGPointMake(self.backgroundView.center.x, backgroundFrame.origin.y + backgroundFrame.size.height - newHeight/2);
                CGRect newFrame = CGRectMake(0, 0, newHeight, newHeight);
                [UIView animateWithDuration:0.1 animations:^{
                    self.squareView.frame = newFrame;
                    self.squareView.center = newCenter;
                }];
            }
        }
            break;
        case RightUpSquare:
        {
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:self.view];
            CGRect backgroundFrame = self.backgroundView.frame;
            CGPoint leftDownPoint = CGPointMake(backgroundFrame.origin.x, backgroundFrame.origin.y + backgroundFrame.size.height);
            CGFloat backgroundDiagonal = sqrt(backgroundFrame.size.height * backgroundFrame.size.width + backgroundFrame.size.height * backgroundFrame.size.height);
            CGFloat diagonal = sqrt((point.x - leftDownPoint.x) * (point.x - leftDownPoint.x) + (point.y - leftDownPoint.y) * (point.y - leftDownPoint.y));
            if (diagonal < sqrt(smallLength*smallLength*2)) {
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + smallLength/2, backgroundFrame.origin.y + backgroundFrame.size.height - smallLength/2);
                CGRect newFrame = CGRectMake(0, 0, smallLength, smallLength);
                self.squareView.frame = newFrame;
                self.squareView.center = newCenter;
            } else if (diagonal > backgroundDiagonal) {
                self.squareView.frame = backgroundFrame;
            } else {
                CGFloat newWidth = sin(M_PI_4) * diagonal;
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + newWidth/2, backgroundFrame.origin.y + backgroundFrame.size.height - newWidth/2);
                CGRect newFrame = CGRectMake(0, 0, newWidth, newWidth);
                [UIView animateWithDuration:0.1 animations:^{
                    self.squareView.frame = newFrame;
                    self.squareView.center = newCenter;
                }];
            }
        }
            break;
        case RightDownSquare:
        {
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:self.view];
            CGRect backgroundFrame = self.backgroundView.frame;
            CGFloat backgroundDiagonal = sqrt(backgroundFrame.size.height * backgroundFrame.size.width + backgroundFrame.size.height * backgroundFrame.size.height);
            CGPoint leftUpPoint = CGPointMake(backgroundFrame.origin.x, backgroundFrame.origin.y);
            CGFloat diagonal = sqrt((point.x - leftUpPoint.x) * (point.x - leftUpPoint.x) + (point.y - leftUpPoint.y) * (point.y - leftUpPoint.y));
            if (diagonal < sqrt(smallLength*smallLength*2)) {
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + smallLength/2, backgroundFrame.origin.y + smallLength/2);
                CGRect newFrame = CGRectMake(0, 0, smallLength, smallLength);
                self.squareView.frame = newFrame;
                self.squareView.center = newCenter;
            } else if (diagonal > backgroundDiagonal) {
                self.squareView.frame = backgroundFrame;
            } else {
                CGFloat newWidth = sin(M_PI_4) * diagonal;
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + newWidth/2, backgroundFrame.origin.y + newWidth/2);
                CGRect newFrame = CGRectMake(0, 0, newWidth, newWidth);
                [UIView animateWithDuration:0.1 animations:^{
                    self.squareView.frame = newFrame;
                    self.squareView.center = newCenter;
                }];
            }
        }
            break;
        case LeftDownSquare:
        {
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:self.view];
            CGRect backgroundFrame = self.backgroundView.frame;
            CGFloat backgroundDiagonal = sqrt(backgroundFrame.size.height * backgroundFrame.size.width + backgroundFrame.size.height * backgroundFrame.size.height);
            CGPoint RightUpPoint = CGPointMake(backgroundFrame.origin.x + backgroundFrame.size.width, backgroundFrame.origin.y);
            CGFloat diagonal = sqrt((point.x - RightUpPoint.x) * (point.x - RightUpPoint.x) + (point.y - RightUpPoint.y) * (point.y - RightUpPoint.y));
            if (diagonal < sqrt(smallLength*smallLength*2)) {
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + backgroundFrame.size.width - smallLength/2, backgroundFrame.origin.y + smallLength/2);
                CGRect newFrame = CGRectMake(0, 0, smallLength, smallLength);
                self.squareView.frame = newFrame;
                self.squareView.center = newCenter;
            } else if (diagonal > backgroundDiagonal) {
                self.squareView.frame = backgroundFrame;
            } else {
                CGFloat newWidth = sin(M_PI_4) * diagonal;
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + backgroundFrame.size.width - newWidth/2, backgroundFrame.origin.y + newWidth/2);
                CGRect newFrame = CGRectMake(0, 0, newWidth, newWidth);
                [UIView animateWithDuration:0.1 animations:^{
                    self.squareView.frame = newFrame;
                    self.squareView.center = newCenter;
                }];
            }
        }
            break;
        case LeftUpSquare:
        {
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:self.view];
            CGRect backgroundFrame = self.backgroundView.frame;
            CGFloat backgroundDiagonal = sqrt(backgroundFrame.size.height * backgroundFrame.size.width + backgroundFrame.size.height * backgroundFrame.size.height);
            CGPoint rightDownPoint = CGPointMake(backgroundFrame.origin.x + backgroundFrame.size.width, backgroundFrame.origin.y + backgroundFrame.size.height);
            CGFloat diagonal = sqrt((point.x - rightDownPoint.x) * (point.x - rightDownPoint.x) + (point.y - rightDownPoint.y) * (point.y - rightDownPoint.y));
            if (diagonal < sqrt(smallLength*smallLength*2)) {
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + backgroundFrame.size.width - smallLength/2, backgroundFrame.origin.y + backgroundFrame.size.height - smallLength/2);
                CGRect newFrame = CGRectMake(0, 0, smallLength, smallLength);
                self.squareView.frame = newFrame;
                self.squareView.center = newCenter;
            } else if (diagonal > backgroundDiagonal) {
                self.squareView.frame = backgroundFrame;
            } else {
                CGFloat newWidth = sin(M_PI_4) * diagonal;
                CGPoint newCenter = CGPointMake(backgroundFrame.origin.x + backgroundFrame.size.width - newWidth/2, backgroundFrame.origin.y + backgroundFrame.size.height - newWidth/2);
                CGRect newFrame = CGRectMake(0, 0, newWidth, newWidth);
                [UIView animateWithDuration:0.1 animations:^{
                    self.squareView.frame = newFrame;
                    self.squareView.center = newCenter;
                }];
            }
        }
            break;
        case Default:
        {
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:self.view];
            CGRect frame = self.imageView.frame;
            frame.origin.x += (point.x - self.beginPoint.x);
            frame.origin.y += (point.y - self.beginPoint.y);
            self.imageView.frame = frame;
            self.beginPoint = point;
        }
        default:
            break;
    }
}

#pragma mark - button actions
-(void)cancelAction
{
    NSLog(@"cancelAction");
    self.cancelBlock(self);
}

-(void)conformAction
{
    NSLog(@"conformAction");
    self.submitBlock(self, self.clipImage);
}

#pragma mark - gesture actions
-(void)pinchViewAction:(UIPinchGestureRecognizer *)sender
{
    NSLog(@"pinchViewAction");
}

-(void)panViewAction:(UIPanGestureRecognizer *)sender
{
    NSLog(@"panViewAction");
    UIView *view = self.view;
    if (sender.state == UIGestureRecognizerStateBegan) {
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
    }
}

#pragma mark - move end
-(void)zoomInWithScaleView
{
    
}

#pragma mark - get subImage
-(UIImage *)getSubImage
{
    CGRect squareFrame = self.cropFrame;
    CGFloat scaleRatio = self.lastFrame.size.width/self.originalImage.size.width;
    // 以下处理是因为图片的尺寸往往和屏幕控件的尺寸大小比例不同，或压缩或放大，截取的时候不能按控件的显示截取，而要根据比例在图片上截取
    CGFloat x = (squareFrame.origin.x - self.lastFrame.origin.x)/scaleRatio;
    CGFloat y = (squareFrame.origin.y - self.lastFrame.origin.y)/scaleRatio;
    CGFloat w = squareFrame.size.width/scaleRatio;
    CGFloat h = squareFrame.size.height/scaleRatio;
    
    CGRect myImageRect = CGRectMake(x, y, w, h);
    CGImageRef imageRef = self.originalImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = myImageRect.size.width;
    size.height = myImageRect.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return smallImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

