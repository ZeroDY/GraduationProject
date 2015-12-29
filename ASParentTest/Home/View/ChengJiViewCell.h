//
//  ChengJiViewCell.h
//  ASParentTest
//
//  Created by 周德艺 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChengJiViewCellDelegate
-(void)submitClick:(NSString *)name andCensus:(NSString *)census andTicket:(NSString *)ticket;
@end
@interface ChengJiViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *censusTextField;
@property (weak, nonatomic) IBOutlet UITextField *ticketTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic,assign)id <ChengJiViewCellDelegate>delegate;

- (IBAction)submitClick:(id)sender;
@end
