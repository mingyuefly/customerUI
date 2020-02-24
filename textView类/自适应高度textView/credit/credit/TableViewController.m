//
//  TableViewController.m
//  credit
//
//  Created by Gguomingyue on 2019/1/16.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "TableViewController.h"
#import "PersonalInfoCell.h"
#import "defines.h"
#import "GMLayoutRate.h"

@interface TableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.edgesForExtendedLayout = UIRectEdgeAll;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"table";
    [self.view addSubview:self.tableView];
}

#pragma mark - getters and setters
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.backgroundColor = [UIColor greenColor];
        
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        //_tableView.tableHeaderView = [[UIView alloc] init];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PersonalInfoCell *cell = [PersonalInfoCell CellWithTableView:tableView Index:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 44;
    if (indexPath.row % 2 == 0) {
        return GMLAYOUTRATE(80);
    }
    return GMLAYOUTRATE(54);
}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return CGFLOAT_MIN;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //return 0.1f;
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
    //return [UIView new];
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return nil;
//    //return [UIView new];
//}


@end
