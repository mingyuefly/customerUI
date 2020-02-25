//
//  ViewController.m
//  CustomActionSheet
//
//  Created by Gguomingyue on 2018/1/9.
//  Copyright © 2018年 Gguomingyue. All rights reserved.
//

#import "ViewController.h"
#import "GMActionSheetViewController.h"
#import "GMImagePicker.h"

@interface ViewController ()<GMImagePickerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)originalAction:(UIButton *)sender;
- (IBAction)custom:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.view.backgroundColor = [UIColor redColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

-(void)tapAction
{
    
}

//-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
//{
//    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
//    self.definesPresentationContext = YES;
//    viewControllerToPresent.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//}

#pragma mark - GMImagePickerDelegate
- (void)imagePickerDidCancel:(GMImagePicker *)imagePicker{
    
}
- (void)imagePicker:(GMImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    self.imageView.image = editedImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)originalAction:(UIButton *)sender {
    GMActionSheetViewController *asvc = [GMActionSheetViewController ActionSheetViewController];
    
    GMSheetAction *cameraAction = [GMSheetAction actionWithTitle:@"拍照" hander:^(GMSheetAction *action) {
        NSLog(@"拍照");
        GMImagePicker *imagePicker = [GMImagePicker sharedInstance];
        imagePicker.delegate = self;
        [imagePicker showOriginalImagePickerWithType:ImagePickerCamera InViewController:self];
        //[imagePicker showImagePickerWithType:ImagePickerCamera InViewController:self Scale:0.75];
    }];
    [asvc addAction:cameraAction];
    GMSheetAction *cancelAction = [GMSheetAction actionWithTitle:@"取消" hander:nil];
    [asvc addCancelAction:cancelAction];
    GMSheetAction *photoAction = [GMSheetAction actionWithTitle:@"从相册中选择" hander:^(GMSheetAction *action) {
        NSLog(@"从相册中选择");
        GMImagePicker *imagePicker = [GMImagePicker sharedInstance];
        imagePicker.delegate = self;
        [imagePicker showOriginalImagePickerWithType:ImagePickerPhoto InViewController:self];
        //[imagePicker showImagePickerWithType:ImagePickerPhoto InViewController:self Scale:1.25];
    }];
    [asvc addAction:photoAction];
    
    [asvc presentWith:self animated:YES completion:nil];
}

- (IBAction)custom:(UIButton *)sender {
    GMActionSheetViewController *asvc = [GMActionSheetViewController ActionSheetViewController];
    GMSheetAction *cancelAction = [GMSheetAction actionWithTitle:@"取消" hander:nil];
    [asvc addCancelAction:cancelAction];
    GMSheetAction *cameraAction = [GMSheetAction actionWithTitle:@"拍照" hander:^(GMSheetAction *action) {
        NSLog(@"拍照");
        GMImagePicker *imagePicker = [GMImagePicker sharedInstance];
        imagePicker.delegate = self;
        //[imagePicker showOriginalImagePickerWithType:ImagePickerCamera InViewController:self];
        [imagePicker showImagePickerWithType:ImagePickerCamera InViewController:self Scale:0.80];
    }];
    [asvc addAction:cameraAction];
    GMSheetAction *photoAction = [GMSheetAction actionWithTitle:@"从相册中选择" hander:^(GMSheetAction *action) {
        NSLog(@"从相册中选择");
        GMImagePicker *imagePicker = [GMImagePicker sharedInstance];
        imagePicker.delegate = self;
        //[imagePicker showOriginalImagePickerWithType:ImagePickerPhoto InViewController:self];
        [imagePicker showImagePickerWithType:ImagePickerPhoto InViewController:self Scale:0.80];
    }];
    [asvc addAction:photoAction];
    [asvc presentWith:self animated:YES completion:nil];
}
@end
