//
//  DYRequestBase+PublishJsgy.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//  发布集思广益评论接口

#import "DYRequestBase.h"

@interface DYRequestBase (PublishJsgy)
+ (void)PublishJsgyByUserId:(NSString *)userId JsgyId:(NSString *)jsgyId CommentContent:(NSString *)commentContent requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;
@end