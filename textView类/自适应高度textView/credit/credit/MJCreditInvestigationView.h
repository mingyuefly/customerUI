//
//  MJCreditInvestigationView.h
//  credit
//
//  Created by Gguomingyue on 2018/12/18.
//  Copyright © 2018 Gmingyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MJCreditInvestigationProtocolBlock)(NSURL *url);
typedef void(^MJCreditInvestigationViewApplyBlock)(void);
typedef void(^MJCreditInvestigationViewBackBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface MJCreditInvestigationView : UIView

@property (nonatomic, copy) MJCreditInvestigationProtocolBlock protocolblock;
@property (nonatomic, copy) MJCreditInvestigationViewBackBlock backBlock;
@property (nonatomic, copy) MJCreditInvestigationViewApplyBlock applyBlock;
@property (nonatomic, strong) NSArray<NSDictionary *> *agreements;

@end

NS_ASSUME_NONNULL_END
