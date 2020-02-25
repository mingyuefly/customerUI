//
//  GMImagePicker.h
//  CustomActionSheet
//
//  Created by Gguomingyue on 2018/1/10.
//  Copyright © 2018年 Gguomingyue. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ImagePickerType){
    ImagePickerCamera = 0,
    ImagePickerPhoto = 1
};

@class GMImagePicker;
@protocol GMImagePickerDelegate<NSObject>
@optional
- (void)imagePicker:(GMImagePicker *)imagePicker didFinished:(UIImage *)editedImage;
- (void)imagePickerDidCancel:(GMImagePicker *)imagePicker;

@end

@interface GMImagePicker : NSObject

@property (nonatomic, weak) id<GMImagePickerDelegate>delegate;

+(instancetype)sharedInstance;

- (void)showOriginalImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController;
- (void)showImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController Scale:(double)scale;


@end
