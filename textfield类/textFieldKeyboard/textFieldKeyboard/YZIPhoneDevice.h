//
//  YZIPhoneDevice.h
//  YZElectCommerce
//
//  Created by study on 2019/7/31.
//  Copyright © 2019 WY. All rights reserved.
//

#ifndef YZIPhoneDevice_h
#define YZIPhoneDevice_h




#define iOS11_Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)
#define iOS9_Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS8_2Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.2f)

// 设备型号
#define IS_IPAD     [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE   [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
//#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


// 判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_X             (IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES)


#define Height_StatusBar (IS_X ? 44.0 : 20.0)
#define Height_Bottom    (IS_X ? 34.0 : 0)
#define Height_NavBar    (IS_X ? 88.0 : 64.0)
#define Height_TabBar    (IS_X ? 83.0 : 49.0)

//安全区域
#define Height_SafeArea  kScreenHeight-Height_NavBar-Height_Bottom
// 屏幕高度
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
// 屏幕宽度
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)



/// 等比缩放 根据 iPhone6 进行适配
#define kScreenWidthScale (kScreenWidth / 375)
#define kScreenHightlyScale (kScreenHeight / 667)

//等比缩放
#define AutoRectMake(x,y,width,height)      CGRectMake((x)*kScreenWidthScale, (y)*kScreenHightlyScale, (width)*kScreenWidthScale, (height)*kScreenHightlyScale)





// 环信 使用的
#define iPhoneX_BOTTOM_HEIGHT  ([UIScreen mainScreen].bounds.size.height==812?34:0)

/// 服务列表 - 排序、性别的TabelViewCell的高度
#define float_serviceMenuCellHeight 40

// ******适配宏*****//
// 判断IPHONE类型
#define yzmiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define yzmiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define yzmiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define yzmiPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define yzmIS_IPHONE_4 ([[UIScreen mainScreen] bounds].size.height <= 480)
#define yzmShortSystemVersion  [[UIDevice currentDevice].systemVersion floatValue]

#define yzmisPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define yzmiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define yzmIS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define yzmIS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define yzmIS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define yzmIS_IPHONE_X_orMore (yzmiPhoneX==YES || yzmIS_IPHONE_Xr== YES || yzmIS_IPHONE_Xs== YES || yzmIS_IPHONE_Xs_Max== YES)

#define YZLAYOUTRATE_FORPLUS(orginLayout) (CGFloat)(layoutRateByHeightForPlus(orginLayout))
#define YZLAYOUTRATE(orginLayout) (CGFloat)(layoutRateByHeight(orginLayout))
#define YZLAYOUTRATE_OC(orginLayout) [YZLayoutRate layoutRateByOCHeight:orginLayout]
#define YZLAYOUTRATEFORPLUS_OC(orginLayout) [YZLayoutRate layoutRateByOCHeightForPlus:orginLayout]
// ******适配宏*****//




#endif /* YZIPhoneDevice_h */
