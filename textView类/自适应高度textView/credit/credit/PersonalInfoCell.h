//
//  PersonalInfoCell.h
//  meijie
//
//  Created by Gguomingyue on 2018/12/13.
//  Copyright © 2018 美借. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalInfoCell : UITableViewCell

+(instancetype)CellWithTableView:(UITableView *)tableView Index:(NSUInteger)index;
@property (nonatomic, assign) NSUInteger index;

@end

NS_ASSUME_NONNULL_END
