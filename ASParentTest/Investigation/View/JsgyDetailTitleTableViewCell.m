//
//  JsgyDetailTitleTableViewCell.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "JsgyDetailTitleTableViewCell.h"
static CGFloat const backViewAndTopPadding = 8.0f;
static CGFloat const backViewAndBottomPadding = 30.0f;
static CGFloat const titleViewHeight = 44.0f;
static CGFloat const contentLabToTitleBackViewPadding = 8.0f;
static CGFloat const contentLabToTimeLabPadding = 8.0f;
static CGFloat const timeLabHeight = 21.0f;

@implementation JsgyDetailTitleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+ (CGFloat)calculateCellHeightWithContentStr:(NSString *)contentStr
{
    CGFloat cellHeight = 0;
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    
    CGSize labelSize = [contentStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-16-18, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    NSLog(@"%f",labelSize.height);
    cellHeight = backViewAndTopPadding + titleViewHeight + contentLabToTitleBackViewPadding + labelSize.height + contentLabToTimeLabPadding + timeLabHeight + backViewAndBottomPadding;
    NSLog(@"%f",cellHeight);
    return cellHeight;
}

@end
