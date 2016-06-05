//
//  KCCalloutAnnotatonView.h
//  MapTest
//
//  Created by 周德艺 on 15/4/24.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "KCCalloutAnnotation.h"

@interface KCCalloutAnnotationView : MKAnnotationView

@property (nonatomic ,strong) KCCalloutAnnotation *annotation;
@property (nonatomic ,strong) UIButton *button;

#pragma mark 从缓存取出标注视图
+(instancetype)calloutViewWithMapView:(MKMapView *)mapView;

@end
