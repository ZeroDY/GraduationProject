//
//  NoteObject.m
//  Footprint
//
//  Created by 周德艺 on 15/5/4.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "NoteObject.h"

@implementation NoteObject

-(void)dateFormat{
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[self.msgcreattime floatValue]/1000];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    self.msgcreattime = [df stringFromDate:dt];
}
@end
