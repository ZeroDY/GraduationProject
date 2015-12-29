//
//  HomeTableViewCell.m
//  ASParentTest
//
//  Created by 周德艺 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSArray *nibArray = [bundle loadNibNamed:reuseIdentifier owner:nil options:nil];
//    self = (HomeTableViewCell *)[nibArray objectAtIndex:0];
//    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//
//    if (self) {
//        
//
//    }
//    return self;
//}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showNewsDetailClick:(id)sender {
    [self.delegate showNewsDetail];
}

- (IBAction)showNewsViewClick:(id)sender {
    [self.delegate showNewsView];
}
@end
