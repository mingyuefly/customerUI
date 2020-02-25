//
//  IconDownloader.h
//  LazyTable
//
//  Created by mingyue on 16/5/28.
//  Copyright © 2016年 csii. All rights reserved.
//

@class AppRecord;

@interface IconDownloader : NSObject

@property (nonatomic, strong) AppRecord *appRecord;
@property (nonatomic, copy) void (^completionHandler)(void);

-(void)startDownload;
-(void)cancelDownload;

@end
