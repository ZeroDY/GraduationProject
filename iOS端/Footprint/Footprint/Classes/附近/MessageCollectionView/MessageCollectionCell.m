//
//  MessageCollectionCell.m
//  CollectView
//
//  Created by 周德艺 on 15/5/23.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "MessageCollectionCell.h"
#import "NoteObject.h"

#define MARGIN 6.0

@interface MessageCollectionCell ()

@end

@implementation MessageCollectionCell


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.captionLabel.font = [UIFont systemFontOfSize:14.0];
        self.captionLabel.numberOfLines = 0;
        [self addSubview:self.captionLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.timeLabel.font = [UIFont systemFontOfSize:9.0];
        self.timeLabel.numberOfLines = 1;
        [self addSubview:self.timeLabel];
        
        self.userLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.userLabel.font = [UIFont systemFontOfSize:9.0];
        self.userLabel.numberOfLines = 1;
        [self addSubview:self.userLabel];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
    self.captionLabel.text = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width - MARGIN * 2;
    CGFloat top = MARGIN;
    CGFloat left = MARGIN;
    // Label
    CGSize labelSize = CGSizeZero;
    labelSize = [self.captionLabel.text sizeWithFont:self.captionLabel.font constrainedToSize:CGSizeMake(width, INT_MAX) lineBreakMode:self.captionLabel.lineBreakMode];
    self.captionLabel.frame = CGRectMake(left, top, labelSize.width, labelSize.height);
    
    // Image
    top = self.captionLabel.frame.origin.y + self.captionLabel.frame.size.height + MARGIN;
    NoteObject *note = (NoteObject *)self.object;
    NSString *string = note.msgimage;
    NSArray *array = [string componentsSeparatedByString:@"x"]; //从字符A中分隔成2个元素的数组
    NSString *wStr = [array objectAtIndex:1];
    NSString *hStr = [array objectAtIndex:2];
    CGFloat imageH = width * (hStr.floatValue/wStr.floatValue);
    self.imageView.frame = CGRectMake(left, top, width, imageH);
    
    top = self.imageView.frame.origin.y + self.imageView.frame.size.height + MARGIN;
    
    self.timeLabel.frame = CGRectMake(left, top, width*0.7, 10);
    self.userLabel.frame = CGRectMake(width*0.6, top, width*0.4 ,10);
}

- (void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index {
    
    [super collectionView:collectionView fillCellWithObject:object atIndex:index];
    
    NoteObject *note = (NoteObject *)object;
    NSString *imgURL = [NSString stringWithFormat:@"%@%@",KGetImage_URL,note.msgimage];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"wall_image01"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];

    self.captionLabel.text = note.msgcontent;
    self.timeLabel.text = note.msgcreattime;
    self.userLabel.text = note.user.truename;
    
    self.captionLabel.textColor = [UIColor darkGrayColor];
    self.timeLabel.textColor = [UIColor darkGrayColor];
    self.userLabel.textColor = NavigationColor;
    
    self.userLabel.textAlignment = NSTextAlignmentRight;
}

+ (CGFloat)rowHeightForObject:(id)object inColumnWidth:(CGFloat)columnWidth {
    NoteObject *note = (NoteObject *)object;
    
    CGFloat height = 0.0;
    CGFloat width = columnWidth - MARGIN * 2;
    
    height += MARGIN*4;
    
    // Label
    NSString *caption = note.msgcontent;
    CGSize labelSize = CGSizeZero;
    UIFont *labelFont = [UIFont boldSystemFontOfSize:14.0];
    labelSize = [caption sizeWithFont:labelFont constrainedToSize:CGSizeMake(width, INT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    height += labelSize.height;
    
    // Image
    NSString *string = note.msgimage;
    
    NSArray *array = [string componentsSeparatedByString:@"x"]; //从字符A中分隔成2个元素的数组
    NSString *hStr = [array objectAtIndex:2];
    NSString *wStr = [array objectAtIndex:1];
    
    CGFloat imageH = width * (hStr.floatValue/wStr.floatValue);

    height += imageH;    
    height += 10;
    
    return height;
}


@end


