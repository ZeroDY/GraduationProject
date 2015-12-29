//
//  NoticeObject.h
//  ASTeacher
//
//  Created by 周德艺 on 15/12/1.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeObject : NSObject

//addtime = "2015-12-18 13:40:31";
//cuser = 04010002;
//idcode = 2c93822851b399740151b39a97c10000;
//szcont = "\U5b66\U751f\U7ec4";
//szid = 1;
//szname = "\U5b66\U751f\U7ec4";
//tcontent = "\U00e5\U00a5\U00bd\U00e5\U00a5\U00bd\U00e5\U00ad\U00a6\U00e4\U00b9\U00a0\U00e5\U00a4\U00a9\U00e5\U00a4\U00a9\U00e5\U0090\U0091\U00e4\U00b8\U008a";
//teaname = "\U674e\U5efa\U529f";
//theader = good;
//tztyppe = 1;

@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *cuser;
@property (nonatomic, copy) NSString *idcode;
@property (nonatomic, copy) NSString *szid;
@property (nonatomic, copy) NSString *szcont;
@property (nonatomic, copy) NSString *szname;
@property (nonatomic, copy) NSString *tcontent;
@property (nonatomic, copy) NSString *theader;
@property (nonatomic, copy) NSString *teaname;
@property (nonatomic, copy) NSString *tztyppe;



@end
