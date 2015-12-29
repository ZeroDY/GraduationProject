//
//  UserProtocolViewController.h
//  HYLottery
//
//  Created by apple on 15/6/29.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProtocolViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
