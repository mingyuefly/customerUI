//
//  GMActionSheet.h
//  GLoanClient
//
//  Created by Gguomingyue on 2018/1/9.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GMSheetAction;
typedef void (^GMSheetActionBlock)(GMSheetAction *action);

@interface GMSheetAction : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) GMSheetActionBlock block;
+(instancetype)actionWithTitle:(NSString *)title hander:(GMSheetActionBlock)hander;

@end

@interface GMActionSheetViewController : UIViewController

+(instancetype)ActionSheetViewController;
-(void)addAction:(GMSheetAction *)action;
-(void)addCancelAction:(GMSheetAction *)action;
-(void)presentWith:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;

@end
