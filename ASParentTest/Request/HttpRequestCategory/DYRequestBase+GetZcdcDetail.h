//
//  DYRequestBase+GetZcdcDetail.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//  查询政策调查详情接口

#import "DYRequestBase.h"

@interface DYRequestBase (GetZcdcDetail)
+ (void)GetZcdcDetailByWenJuanId:(NSString *)wenjuanId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;
@end
