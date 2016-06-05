//
//  MapLocationObject.h
//  Footprint
//
//  Created by 周德艺 on 15/5/2.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef void (^MyBlockType)();

@interface RefreshLocation : UIView<CLLocationManagerDelegate,MKMapViewDelegate>

@property(nonatomic, copy) MyBlockType block;
@property(nonatomic,strong) CLLocationManager *locationManager;
@property(nonatomic,strong) CLGeocoder *geocoder;

@property(nonatomic,strong) UILabel *lable;

+ (instancetype) shareInstance ;

-(void)RefreshLocationLable:(UILabel*) label andBlock:(MyBlockType) function;

@end
