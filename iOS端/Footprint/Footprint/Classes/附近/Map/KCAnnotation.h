//
//  KCAnnotation.h
//  MapTest
//
//  Created by 周德艺 on 15/4/24.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WallObject.h"

@interface KCAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) int wallindex;

#pragma mark 自定义一个图片属性在创建大头针视图时使用
@property (nonatomic,strong) UIImage *image;

#pragma mark 背景图
@property (nonatomic,strong) UIImage *bgimage;
#pragma mark 标题
@property (nonatomic,copy) NSString *title;
#pragma mark 标题
@property (nonatomic,copy) NSString *signature;
#pragma mark 进入按钮
@property (nonatomic, strong)UIButton *button;

@end
