//
//  LocationObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationObject : NSObject
//xianquname: "槐荫区",
//gpsid: 2,
//weizhitype: 0,
//addtime: "2015-12-21 17:18:12",
//address: "济南市槐荫区五院旁",
//techname: "济南市槐荫区教育局",
//stuname: "毕耜发",
//weizhiname: "校门出口",
//stcont: "营东小学",
//schoolcensus: "2011370102000120001"
@property (nonatomic , copy) NSString *xianquname;
@property (nonatomic , copy) NSString *gpsid;
@property (nonatomic , copy) NSString *weizhitype;
@property (nonatomic , copy) NSString *addtime;
@property (nonatomic , copy) NSString *address;
@property (nonatomic , copy) NSString *techname;
@property (nonatomic , copy) NSString *stuname;
@property (nonatomic , copy) NSString *weizhiname;
@property (nonatomic , copy) NSString *stcont;
@property (nonatomic , copy) NSString *schoolcensus;
@end
