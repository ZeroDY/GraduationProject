//
//  MapViewController.h
//  Footprint
//
//  Created by 周德艺 on 15/4/27.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MapViewController : UIViewController

@property (nonatomic, strong) NSString *mapType;
@property (nonatomic, strong) UserObject *user;
@property (nonatomic, strong) NSMutableArray *wallArr;
@property (weak, nonatomic) IBOutlet UIButton *nowLocation_btn;
@property (weak, nonatomic) IBOutlet UIButton *change_btn;

- (IBAction)changeMap:(id)sender;
- (IBAction)nowLocation:(id)sender;



@end
