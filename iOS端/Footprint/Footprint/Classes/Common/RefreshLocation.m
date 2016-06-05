//
//  MapLocationObject.m
//  Footprint
//
//  Created by 周德艺 on 15/5/2.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "RefreshLocation.h"

double KLongitude;
double KLatitude;
NSString *KLocation;

@implementation RefreshLocation

static RefreshLocation * _instance = nil;

+(instancetype) shareInstance
{
    if (_instance == nil) {
        _instance = [[RefreshLocation alloc]init];
        _instance.lable = [[UILabel alloc]init];
        _instance.geocoder=[[CLGeocoder alloc]init];
    }
    return _instance ;
}

#pragma mark - 创建定位服务

-(void)RefreshLocationLable:(UILabel *) label andBlock:(MyBlockType)function{
    self.lable = label;
    self.block = function;
    _locationManager=[[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        CLLocationDistance distance=10.0;
        _locationManager.distanceFilter=distance;
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];
    if (![WGS84TOGCJ02 isLocationOutOfChina:[location coordinate]]) {
        CLLocationCoordinate2D coord = [WGS84TOGCJ02 transformFromWGSToGCJ:[location coordinate]];
        KLongitude = coord.longitude;
        KLatitude = coord.latitude;
        NSLog(@"----->>>>>%f---->>>>>%f",coord.longitude,coord.latitude);
        [self getAddressByLatitude:KLatitude longitude:KLongitude];
        if (self.block) {
            self.block();
        }
    }
    [_locationManager stopUpdatingLocation];
}
#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        KLocation = placemark.name;
        self.lable.text = KLocation;
    }];
}





@end