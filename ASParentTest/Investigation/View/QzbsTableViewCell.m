//
//  QzbsTableViewCell.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/23.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "QzbsTableViewCell.h"
static CGFloat const contentLabToTitleBackViewBottomPadding = 20.0f;
static CGFloat const timeLabToBackViewPadding = 8.0f;
static CGFloat const timeLabHeight = 21.0f;
@implementation QzbsTableViewCell

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
    
    CGSize labelSize = [contentStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-90, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    cellHeight = labelSize.height + +contentLabToTitleBackViewBottomPadding*2 + timeLabToBackViewPadding+timeLabHeight;
    return cellHeight;
}
@end
