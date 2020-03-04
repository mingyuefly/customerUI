//
//  BackgroundView.h
//  MBProgressedHUD
//
//  Created by Gguomingyue on 2018/5/17.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MBProgressHUDBackgroundStyle) {
    /// Solid color background
    MBProgressHUDBackgroundStyleSolidColor,
    /// UIVisualEffectView or UIToolbar.layer background view
    MBProgressHUDBackgroundStyleBlur
};

@interface BackgroundView : UIView

/**
 * The background style.
 * Defaults to MBProgressHUDBackgroundStyleBlur on iOS 7 or later and MBProgressHUDBackgroundStyleSolidColor otherwise.
 * @note Due to iOS 7 not supporting UIVisualEffectView, the blur effect differs slightly between iOS 7 and later versions.
 */
@property (nonatomic) MBProgressHUDBackgroundStyle style;

/**
 * The blur effect style, when using MBProgressHUDBackgroundStyleBlur.
 * Defaults to UIBlurEffectStyleLight.
 */
@property (nonatomic) UIBlurEffectStyle blurEffectStyle;

/**
 * The background color or the blur tint color.
 * @note Due to iOS 7 not supporting UIVisualEffectView, the blur effect differs slightly between iOS 7 and later versions.
 */
@property (nonatomic, strong) UIColor *color;

@end
