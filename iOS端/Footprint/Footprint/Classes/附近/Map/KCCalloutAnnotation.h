//
//  KCCalloutAnnotation.h
//  MapTest
//
//  Created by 周德艺 on 15/4/24.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface KCCalloutAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic) int wallindex;

#pragma mark 背景图
@property (nonatomic,strong) UIImage *bgimage;
#pragma mark 标题
@property (nonatomic,copy) NSString *title;
#pragma mark 描述
@property (nonatomic,copy) NSString *signature;
#pragma mark 进入按钮
@property (nonatomic, strong)UIButton *button;

@end