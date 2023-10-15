//
//  ShareModel.m
//  activityOC
//
//  Created by gmy on 2023/10/8.
//

#import "ShareModel.h"

@implementation ShareModel

+(instancetype)modelWithShowIcon:(UIImage *)showIcon showTitle:(NSString *)showTitle showSubTitle:(NSString *)showSubTitle data:(id)data {
    ShareModel *shareModel = [[ShareModel alloc] init];
    shareModel.showIcon = showIcon;
    shareModel.showTitle = showTitle;
    shareModel.showSubTitle = showSubTitle;
    shareModel.data =data;
    return shareModel;
}

@end
