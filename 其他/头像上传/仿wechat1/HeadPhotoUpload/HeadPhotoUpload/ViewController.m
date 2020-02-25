//
//  ViewController.m
//  HeadPhotoUpload
//
//  Created by Gguomingyue on 2018/1/26.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "GMActionSheetViewController.h"
#import "GMImagePicker.h"

@interface ViewController ()<GMImagePickerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)selectAction:(id)sender {
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


@end
