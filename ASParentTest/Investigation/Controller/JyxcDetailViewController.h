//
//  JyxcDetailViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JyxcDetailObject.h"
@interface JyxcDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *objLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (nonatomic , strong)NSString *idCode;
@property (nonatomic , strong)JyxcDetailObject *jyxcDetailObj;
@end
