//
//  NoticeDetailObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeDetailObject : NSObject
//addtime = "2015-12-20 22:47:28";
//cuser = 04010002;
//idcode = 402881ec51bfd9120151bfdc0f700000;
//picList = "/upload/img/ecbd5761f9274f4dae627e0f017ea423.png";
//szid = 1;
//szname = "\U5b66\U751f\U7ec4";
//tcontent = 123654789;
//teaname = "\U674e\U5efa\U529f";
//theader = 123;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *cuser;
@property (nonatomic, copy) NSString *idcode;
@property (nonatomic, copy) NSString *picList;
@property (nonatomic, copy) NSString *szid;
@property (nonatomic, copy) NSString *szname;
@property (nonatomic, copy) NSString *tcontent;
@property (nonatomic, copy) NSString *theader;
@property (nonatomic, copy) NSString *teaname;

@end
