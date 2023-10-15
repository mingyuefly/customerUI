//
//  ShareViewModel.m
//  activityOC
//
//  Created by gmy on 2023/10/8.
//

#import "ShareViewModel.h"
#import <LinkPresentation/LPLinkMetadata.h>

@interface ShareViewModel () <UIActivityItemSource>

@end

@implementation ShareViewModel

+(instancetype)viewModelWithModel:(ShareModel *)model {
    ShareViewModel *shareViewModel = [[ShareViewModel alloc] init];
    shareViewModel.shareModel = model;
    return shareViewModel;
}

#pragma mark - UIActivityItemSource
- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController {
    return self.shareModel.data;
}

- (nullable id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(nullable UIActivityType)activityType {
    return self.shareModel.data;
}

- (nullable LPLinkMetadata *)activityViewControllerLinkMetadata:(UIActivityViewController *)activityViewController {
    LPLinkMetadata *metaData = [[LPLinkMetadata alloc] init];  // iOS13
    // 只有分享的是URL或UIImage时，设置title才生效
    // text时，一直固定显示Plain Text
    if (self.shareModel.showTitle) {
        metaData.title = self.shareModel.showTitle;
    }
    
    if (self.shareModel.showSubTitle) {
        metaData.originalURL = [NSURL fileURLWithPath:self.shareModel.showSubTitle];
    }
    
    // 设置icon
    if (self.shareModel.showIcon) {
        UIImage *iconImage = self.shareModel.showIcon; 
        NSItemProvider *iconProvider = [[NSItemProvider alloc] initWithObject:iconImage];
        metaData.iconProvider = iconProvider;
    }

    return metaData;
}

@end
