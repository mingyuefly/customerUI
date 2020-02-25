//
//  ParseOperation.h
//  LazyTable
//
//  Created by mingyue on 16/5/28.
//  Copyright © 2016年 csii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseOperation : NSOperation

@property (nonatomic, copy) void (^errorHandler)(NSError *error);
@property (nonatomic, strong, readonly) NSArray *appRecordList;

-(instancetype)initWithData:(NSData *)data;

@end
