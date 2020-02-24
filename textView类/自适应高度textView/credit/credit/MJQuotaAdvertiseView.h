//
//  MJQuotaAdvertiseView.h
//  credit
//
//  Created by Gguomingyue on 2018/12/19.
//  Copyright © 2018 Gmingyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MJQuotaAdvertiseViewCompleteBlock)(void);
typedef void(^MJQuotaAdvertiseViewBackBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface MJQuotaAdvertiseView : UIView

@property (nonatomic, copy)MJQuotaAdvertiseViewCompleteBlock completeBlock;
@property (nonatomic, copy)MJQuotaAdvertiseViewBackBlock backBlock;

@end

NS_ASSUME_NONNULL_END
