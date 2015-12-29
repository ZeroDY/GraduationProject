//
//  DYRequestBase+GetJiaoShuYuRenList.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase.h"

@interface DYRequestBase (GetJiaoShuYuRenList)
+ (void)getJiaoShuYuRenListByCurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;

@end
