//
//  ShareViewModel.h
//  activityOC
//
//  Created by gmy on 2023/10/8.
//

#import <UIKit/UIKit.h>
#import "ShareModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShareViewModel : NSObject

@property (nonatomic, strong) ShareModel *shareModel;
+(instancetype)viewModelWithModel:(ShareModel *)model;

@end

NS_ASSUME_NONNULL_END
