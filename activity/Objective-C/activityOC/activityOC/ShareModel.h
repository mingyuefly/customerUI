//
//  ShareModel.h
//  activityOC
//
//  Created by gmy on 2023/10/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareModel : NSObject

@property (nonatomic, strong) UIImage *showIcon;
@property (nonatomic, copy) NSString *showTitle;
@property (nonatomic, copy) NSString *showSubTitle;
@property (nonatomic, strong) id data;
+(instancetype)modelWithShowIcon:(UIImage *)showIcon showTitle:(NSString *)showTitle showSubTitle:(NSString *)showSubTitle data:(id)data;

@end

NS_ASSUME_NONNULL_END
