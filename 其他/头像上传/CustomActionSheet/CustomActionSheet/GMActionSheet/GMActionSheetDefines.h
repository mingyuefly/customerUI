//
//  GMActionSheetDefines.h
//  CustomActionSheet
//
//  Created by Gguomingyue on 2018/1/9.
//  Copyright © 2018年 Gguomingyue. All rights reserved.
//

#ifndef GMActionSheetDefines_h
#define GMActionSheetDefines_h

#define font18 [UIFont systemFontOfSize:GMFONTSCALE(18)]
// 字体
#define GMFONTSCALE(originFont) DEVICE_HEIGHT > 568 ? originFont : (originFont - 2)
#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height

// 全局背景色
#define KGlobalViewBgColor [UIColor colorWithRGBString:@"#FAFAFA"]

#define GMLAYOUTRATE(orginLayout) (CGFloat)(layoutRateByHeight(orginLayout))

#endif /* GMActionSheetDefines_h */
