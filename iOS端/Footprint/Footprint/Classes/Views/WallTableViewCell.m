//
//  WallTableViewCell.m
//  FootprintWall
//
//  Created by 张浩 on 15/4/23.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import "WallTableViewCell.h"


@implementation WallTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(IBAction)like:(id)sender{
    [_delegate likeInfo:(int)self.tag];
}

-(IBAction)comment:(id)sender{
    [_delegate commentInfo:(int)self.tag];
}

-(IBAction)user:(id)sender{
    [_delegate showUserVote:(int)self.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
