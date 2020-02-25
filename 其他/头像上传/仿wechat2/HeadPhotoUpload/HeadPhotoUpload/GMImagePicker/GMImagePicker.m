//
//  GMImagePicker.m
//  CustomActionSheet
//
//  Created by Gguomingyue on 2018/1/10.
//  Copyright © 2018年 Gguomingyue. All rights reserved.
//

#import "GMImagePicker.h"
#import "GMActionSheetDefines.h"
#import "GMCropImageViewController.h"
#import "MYPhotoSelectViewController.h"

@interface GMImagePicker ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    BOOL isScale;
    double _scale;
}
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) GMCropImageViewController *cropImageViewController;
@property (nonatomic, strong) MYPhotoSelectViewController *photoSelectViewController;

@end

@implementation GMImagePicker

#pragma mark - constructed functions
+(instancetype)sharedInstance
{
    static GMImagePicker *imagePicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imagePicker = [[GMImagePicker alloc] init];
    });
    return imagePicker;
}

#pragma mark - show
-(void)showImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController Scale:(double)scale
{
    if (type == ImagePickerCamera) {
        self.imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    }else{
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePickerController.allowsEditing = NO;
    isScale = YES;
    if(scale>0 && scale<=1.5){
        _scale = scale;
    }else{
        _scale = 1;
    }
    [viewController presentViewController:_imagePickerController animated:YES completion:nil];
}

-(void)showOriginalImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController
{
    if (type == ImagePickerCamera) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    isScale = NO;
    self.imagePickerController.allowsEditing = YES;
    [viewController presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageOrientation imageOrientation=image.imageOrientation;
    if(imageOrientation!=UIImageOrientationUp){
        // Adjust picture Angle
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    __weak typeof(self) weakSelf = self;
    self.photoSelectViewController = [[MYPhotoSelectViewController alloc] initWithImage:image];
    self.photoSelectViewController.submitBlock = ^(UIViewController *viewController, UIImage *image) {
        [viewController dismissViewControllerAnimated:YES completion:nil];
        if ([weakSelf.delegate respondsToSelector:@selector(imagePicker:didFinished:)]) {
            [weakSelf.delegate imagePicker:weakSelf didFinished:image];
        }
    };
    self.photoSelectViewController.cancelBlock = ^(UIViewController *viewController) {
        UIImagePickerController *picker = (UIImagePickerController *)viewController.navigationController;
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            [viewController.navigationController dismissViewControllerAnimated:YES    completion:nil];
        } else {
            [viewController.navigationController popViewControllerAnimated:YES];
        }
    };
    [picker pushViewController:self.photoSelectViewController animated:YES];
    
//    if (isScale) {
//        self.cropImageViewController = [[GMCropImageViewController alloc] initWithImage:image cropFrame:CGRectMake(0, (DEVICE_HEIGHT - DEVICE_WIDTH * _scale)/2, DEVICE_WIDTH, DEVICE_WIDTH * _scale) limitScaleRatio:5];
//        __weak typeof(self) weakSelf = self;
//        self.cropImageViewController.submitBlock = ^(UIViewController *viewController, UIImage *image) {
//            [viewController dismissViewControllerAnimated:YES completion:nil];
//            if ([weakSelf.delegate respondsToSelector:@selector(imagePicker:didFinished:)]) {
//                [weakSelf.delegate imagePicker:weakSelf didFinished:image];
//            }
//        };
//        self.cropImageViewController.cancelBlock = ^(UIViewController *viewController) {
//            UIImagePickerController *picker = (UIImagePickerController *)viewController.navigationController;
//            if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//                [viewController.navigationController dismissViewControllerAnimated:YES    completion:nil];
//            } else {
//                [viewController.navigationController popViewControllerAnimated:YES];
//            }
//        };
//        [picker pushViewController:self.cropImageViewController animated:YES];
//    }else{
//        [picker dismissViewControllerAnimated:YES completion:^{}];
//        if ([self.delegate respondsToSelector:@selector(imagePicker:didFinished:)]) {
//            [self.delegate imagePicker:self didFinished:image];
//        }
//    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    if ([self.delegate respondsToSelector:@selector(imagePickerDidCancel:)]) {
        [self.delegate imagePickerDidCancel:self];
    }
}

#pragma mark - setters and getters
-(UIImagePickerController *)imagePickerController
{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = NO;
    }
    return _imagePickerController;
}

@end
