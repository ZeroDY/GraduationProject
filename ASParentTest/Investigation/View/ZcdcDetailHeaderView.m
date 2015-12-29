//
//  ZcdcDetailHeaderView.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "ZcdcDetailHeaderView.h"

static CGFloat const backViewAndTopPadding = 8.0f;
static CGFloat const backViewAndBottomPadding = 8.0f;
static CGFloat const titleLabAndTopPadding = 8.0f;
static CGFloat const titleLabAndBottomPadding = 8.0f;

@implementation ZcdcDetailHeaderView

+ (CGFloat)calculateViewHeightWithContentStr:(NSString *)contentStr
{
    CGFloat viewHeight = 0;
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
    
    CGSize labelSize = [contentStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-16, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    viewHeight = backViewAndTopPadding + labelSize.height + backViewAndBottomPadding + titleLabAndTopPadding + titleLabAndBottomPadding;
    return viewHeight;
}
@end
