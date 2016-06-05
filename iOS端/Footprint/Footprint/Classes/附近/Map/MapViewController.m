//
//  MapViewController.m
//  Footprint
//
//  Created by 周德艺 on 15/4/27.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "KCAnnotation.h"
#import "KCCalloutAnnotation.h"
#import "KCCalloutAnnotatonView.h"
#import "WallObject.h"
#import "MessageCollectionViewController.h"

@interface MapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>{
    
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGUI];
    [self.view bringSubviewToFront:self.change_btn];
    [self.view bringSubviewToFront:self.nowLocation_btn];
}

#pragma mark 添加地图控件
-(void)initGUI{
    CGRect rect=[UIScreen mainScreen].bounds;
    _mapView=[[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];
    //设置代理
    _mapView.delegate = self;
    
    //请求定位服务
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode            = MKUserTrackingModeFollow;
    //设置地图类型
    _mapView.mapType                     = MKMapTypeStandard;
    //添加大头针
    [self addAnnotation];
}

#pragma mark 添加大头针
-(void)addAnnotation{
    for (int i = 0; i < self.wallArr.count; i ++ ) {
        WallObject *wall = [self.wallArr objectAtIndex:i];
        CLLocationCoordinate2D location1     = CLLocationCoordinate2DMake(wall.ycoordinate,wall.xcoordinate);
        KCAnnotation *annotation1 = [[KCAnnotation alloc]init];
        annotation1.wallindex = i;
        annotation1.title                    = wall.wallname;
        annotation1.coordinate               = location1;
        annotation1.image                    = [UIImage imageNamed:@"print"];
        annotation1.bgimage                  = [UIImage imageNamed:[ NSString stringWithFormat:@"wall_image0%i",i+1]];
        annotation1.signature                = wall.wallsignature;
        [_mapView addAnnotation:annotation1];
    }
}

#pragma mark - 地图控件代理方法
#pragma mark 更新用户位置，只要用户改变则调用此方法（包括第一次定位到用户位置）
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"========>>>>>>%f====>>>>>>>%f",userLocation.coordinate.longitude,userLocation.coordinate.latitude);
    //设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
    //    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    //    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    //    [_mapView setRegion:region animated:true];
}

#pragma mark - 地图控件代理方法
#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[KCAnnotation class]]) {
        static NSString *key1=@"AnnotationKey1";
        MKAnnotationView *annotationView=[_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView  = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
        }
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation            = annotation;
        annotationView.image                 = ((KCAnnotation *)annotation).image;//设置大头针视图的图片
        return annotationView;
    }else if([annotation isKindOfClass:[KCCalloutAnnotation class]]){
        //对于作为弹出详情视图的自定义大头针视图无弹出交互功能（canShowCallout=false，这是默认值），在其中可以自由添加其他视图（因为它本身继承于UIView）
        KCCalloutAnnotationView *calloutView = [KCCalloutAnnotationView calloutViewWithMapView:mapView];
        calloutView.canShowCallout = YES;
        calloutView.button.tag = ((KCCalloutAnnotation*)annotation).wallindex;
        [calloutView.button addTarget:self action:@selector(goWallVC:) forControlEvents:UIControlEventTouchUpInside];
        calloutView.annotation               = annotation;
        return calloutView;
    } else {
        return nil;
    }
}
- (IBAction)goWallVC:(id)sender{
    NSLog(@"ssssssssssssssssssss");
    UIButton *btn = (UIButton *)sender;
    MessageCollectionViewController *msgVC = [[MessageCollectionViewController alloc]initWithNibName:@"MessageCollectionViewController" bundle:nil];
    msgVC.wall = [self.wallArr objectAtIndex:btn.tag];
    msgVC.user = self.user;
    [self.navigationController pushViewController:msgVC animated:YES];
}

#pragma mark 选中大头针时触发
//点击一般的大头针KCAnnotation时添加一个大头针作为所点大头针的弹出详情视图
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    [_mapView bringSubviewToFront:view];
    view.canShowCallout = YES;
    KCAnnotation *annotation             = view.annotation;
    if ([view.annotation isKindOfClass:[KCAnnotation class]]) {
        //点击一个大头针时移除其他弹出详情视图
        //       [self removeCustomAnnotation];
        //添加详情大头针，渲染此大头针视图时将此模型对象赋值给自定义大头针视图完成自动布局
        KCCalloutAnnotation *annotation1=[[KCCalloutAnnotation alloc]init];
        annotation1.wallindex = annotation.wallindex;
        annotation1.bgimage                  = annotation.bgimage;
        annotation1.title                    = annotation.title;
        annotation1.signature                = annotation.signature;
        annotation1.coordinate               = view.annotation.coordinate;
        [mapView addAnnotation:annotation1];
    }
    //设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
    MKCoordinateSpan span                = MKCoordinateSpanMake(0.01, 0.01);
    CLLocationCoordinate2D coordinate    = CLLocationCoordinate2DMake(view.annotation.coordinate.latitude+0.002, view.annotation.coordinate.longitude);
    MKCoordinateRegion region            = MKCoordinateRegionMake(coordinate, span);
    [_mapView setRegion:region animated:YES];
}


#pragma mark 取消选中时触发
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    [self removeCustomAnnotation];
}

#pragma mark 移除所用自定义大头针
-(void)removeCustomAnnotation{
    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[KCCalloutAnnotation class]]) {
            [_mapView removeAnnotation:obj];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 修改地图类型
- (IBAction)changeMap:(id)sender {
    [_mapView setMapType:(_mapView.mapType == MKMapTypeStandard)? MKMapTypeSatellite : MKMapTypeStandard];
}

#pragma mark - 修改显示区域
- (IBAction)nowLocation:(id)sender {
    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[MKUserLocation class]]) {
            MKUserLocation *userLocation         = (MKUserLocation *)obj;
            NSLog(@"dizhi-----%f,%f",userLocation.coordinate.longitude,userLocation.coordinate.latitude);
            MKCoordinateSpan span                = MKCoordinateSpanMake(0.01, 0.01);
            MKCoordinateRegion region            = MKCoordinateRegionMake(userLocation.coordinate, span);
            [_mapView setRegion:region animated:YES];
        }
    }];
}

@end
