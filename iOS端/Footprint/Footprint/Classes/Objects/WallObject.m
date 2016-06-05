//
//  WallObject.m
//  Footprint
//
//  Created by 周德艺 on 15/4/27.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "WallObject.h"

@implementation WallObject

-(void)dateFormat{
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[self.wallcreattime floatValue]/1000.0];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    self.wallcreattime = [df stringFromDate:dt];
}

@end
