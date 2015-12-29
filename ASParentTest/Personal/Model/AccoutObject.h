//
//  AccoutObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/27.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AccoutObject : NSObject

//"ptmail":null,
//"addtime":null,
//"ptstyle":0,
//"nickname":"zzc",
//"idcode":"1",
//"jiaozhang":null,
//"psignature":null,
//"truname":"asd1",
//"ppassword":"456",
//"pphone":"123",
//"puflag":0,
//"pteacher":null

@property (nonatomic , copy) NSString *ptmail;
@property (nonatomic , copy) NSString *addtime;
@property (nonatomic , strong) NSNumber *ptstyle;
@property (nonatomic , copy) NSString *nickname;
@property (nonatomic , copy) NSString *idcode;//userId
@property (nonatomic , copy) NSString *jiaozhang;
@property (nonatomic , copy) NSString *psignature;
@property (nonatomic , copy) NSString *truname;
@property (nonatomic , copy) NSString *ppassword;
@property (nonatomic , copy) NSString *pphone;
@property (nonatomic , strong) NSNumber *puflag;
@property (nonatomic , copy) NSString *pteacher;

@end
