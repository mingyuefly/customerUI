//
//  ActionSheetCell.h
//  LoanClient
//
//  Created by Gguomingyue on 2018/1/9.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMActionSheetCellModel.h"

@interface GMActionSheetCell : UITableViewCell

@property (nonatomic, strong) GMActionSheetCellModel *model;

+(instancetype)CellWithTableView:(UITableView *)tableView;

@end
