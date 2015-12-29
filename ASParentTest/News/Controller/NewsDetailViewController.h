//
//  NewsDetailViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewObject.h"
@interface NewsDetailViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic , strong)NewObject *newsObj;
@end
