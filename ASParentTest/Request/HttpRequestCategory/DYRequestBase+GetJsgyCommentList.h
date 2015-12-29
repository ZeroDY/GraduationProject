//
//  DYRequestBase+GetJsgyCommentList.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//  查询集思广益评论列表接口

#import "DYRequestBase.h"

@interface DYRequestBase (GetJsgyCommentList)
+ (void)GetJsgyCommentListByUserId:(NSString *)userId JsgyId:(NSString *)jsgyId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;

@end
