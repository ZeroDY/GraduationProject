//
//  ZcdcDetailTableViewCell.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "ZcdcDetailTableViewCell.h"
static CGFloat const titleLabAndTopPadding = 8.0f;
static CGFloat const titleLabAndBottomPadding = 8.0f;
@implementation ZcdcDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //给backView一个点击事件
    self.backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseOpetionalClick)];
    [self.backView addGestureRecognizer:click];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)chooseOpetionalClick{
    [self.delegate chooseOptionalClick:self.backView];
}
+ (CGFloat)calculateCellHeightWithContentStr:(NSString *)contentStr
{
    CGFloat cellHeight = 0;
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
    
    CGSize labelSize = [contentStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-34, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    cellHeight = labelSize.height + titleLabAndTopPadding + titleLabAndBottomPadding;
    return cellHeight;
}
@end
