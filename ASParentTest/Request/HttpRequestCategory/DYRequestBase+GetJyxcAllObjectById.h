//
//  DYRequestBase+GetJyxcAllObjectById.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/27.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase.h"

@interface DYRequestBase (GetJyxcAllObjectById)
+ (void)getJyxcAllObjectById:(NSString *)uid requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;
@end
