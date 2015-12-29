//
//  JsgyDetailContentTableViewCell.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "JsgyDetailContentTableViewCell.h"
static CGFloat const backViewAndBottomPadding = 4.0f;
static CGFloat const contentLabToBackViewPadding = 8.0f;
static CGFloat const contentLabToTimeLabPadding = 8.0f;
static CGFloat const timeLabHeight = 21.0f;


@implementation JsgyDetailContentTableViewCell

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
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
    
    CGSize labelSize = [contentStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-16-18, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    cellHeight = contentLabToBackViewPadding + labelSize.height + contentLabToTimeLabPadding + timeLabHeight + backViewAndBottomPadding;
    return cellHeight;
}
@end
