//
//  RootViewController.m
//  LazyTable
//
//  Created by mingyue on 16/5/27.
//  Copyright © 2016年 csii. All rights reserved.
//

#import "RootViewController.h"
#import "AppRecord.h"
#import "IconDownloader.h"

#define kCustomRowCount 7

static NSString *CellIdentifer = @"LazyTableCell";
static NSString *PlaceholderCellIdentifer = @"PlaceholderCell";

@interface RootViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageDownloadsInProgress = [NSMutableDictionary dictionary];
}

-(void)terminatedAllDownloads {
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    [self.imageDownloadsInProgress removeAllObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self terminatedAllDownloads];
}

-(void)dealloc {
    
    [self terminatedAllDownloads];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger count = self.entries.count;
    if (count == 0) {
        return kCustomRowCount;
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    NSUInteger nodeCount = self.entries.count;
    
    if (nodeCount == 0 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:PlaceholderCellIdentifer forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer forIndexPath:indexPath];
        if (nodeCount > 0) {
            AppRecord *appRecord = (self.entries)[indexPath.row];
            cell.textLabel.text = appRecord.appName;
            cell.detailTextLabel.text = appRecord.artist;
            
            if (!appRecord.appIcon) {
                if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
                    [self startIconDownload:appRecord forIndextPath:indexPath];
                }
                cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
            } else {
                cell.imageView.image = appRecord.appIcon;
            }
        }
    }
    
    return cell;
}

#pragma mark - Table cell image support

-(void)startIconDownload:(AppRecord *)appRecord forIndextPath:(NSIndexPath *)indexPath {
    IconDownloader *iconDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (iconDownloader == nil) {
        iconDownloader = [[IconDownloader alloc]init];
        iconDownloader.appRecord = appRecord;
        [iconDownloader setCompletionHandler:^{
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.imageView.image = appRecord.appIcon;
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
        }];
        (self.imageDownloadsInProgress)[indexPath] = iconDownloader;
        [iconDownloader startDownload];
    }
}

-(void)loadImagesForOnscreenRows {
    if (self.entries.count > 0) {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];//目前屏幕上显示的index
        for (NSIndexPath *indexPath in visiblePaths) {
            AppRecord *appRecord = (self.entries)[indexPath.row];
            if (!appRecord.appIcon) {
                [self startIconDownload:appRecord forIndextPath:indexPath];
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {//停止滑动
    if (!decelerate) {//停止减速后再加载
        [self loadImagesForOnscreenRows];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {//停止减速
    [self loadImagesForOnscreenRows];
}


@end
