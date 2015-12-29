//
//  ChengJiViewCell.m
//  ASParentTest
//
//  Created by 周德艺 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "ChengJiViewCell.h"

@implementation ChengJiViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)submitClick:(id)sender {
    [self.delegate submitClick:self.nameTextField.text andCensus:self.censusTextField.text andTicket:self.ticketTextField.text];
}
@end
