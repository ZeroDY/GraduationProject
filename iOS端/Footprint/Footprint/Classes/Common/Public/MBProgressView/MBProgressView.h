//
//  MBProgressView.h
//  EnjoyPublic
//
//  Created by ONCE on 12-11-9.
//
//
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface MBProgressView : UIView<MBProgressHUDDelegate>{
    MBProgressHUD *mbProgressHUD;
}
@property(nonatomic ,retain) MBProgressHUD *mbProgressHUD;

+(MBProgressView*)shareMBProgressView;
-(void)showProgressHUD:(UIView*)theView title:(NSString*)theTitle;
-(void)dissMissProgressHUD;
@end
