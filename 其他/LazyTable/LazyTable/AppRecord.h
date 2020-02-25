//
//  AppRecord.h
//  LazyTable
//
//  Created by mingyue on 16/5/28.
//  Copyright © 2016年 csii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppRecord : NSObject

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) UIImage *appIcon;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *appURLString;

@end
