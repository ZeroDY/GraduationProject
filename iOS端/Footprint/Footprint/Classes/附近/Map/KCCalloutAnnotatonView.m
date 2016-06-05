//
//  KCCalloutAnnotatonView.m
//  MapTest
//
//  Created by 周德艺 on 15/4/24.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "KCCalloutAnnotatonView.h"
#import "MessageCollectionViewController.h"
#define kSpacing 5
#define kTitleFontSize 28
#define kDetailFontSize 16
#define kViewOffset 80

@interface KCCalloutAnnotationView(){
    UIView *_backgroundView;
    UIImageView *_bgimageView;
    UILabel *_wallTitle_Label;
    UILabel *_wallSignature_Label;
}

@end

@implementation KCCalloutAnnotationView

-(instancetype)init{
    if(self=[super init]){
        [self layoutUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    //背景
    _backgroundView=[[UIView alloc]init];
    _backgroundView.backgroundColor=[UIColor lightGrayColor];
    //图片
    _bgimageView=[[UIImageView alloc]init];
    
    //标题
    _wallTitle_Label=[[UILabel alloc]init];
    _wallTitle_Label.lineBreakMode=NSLineBreakByWordWrapping;
    _wallTitle_Label.font=[UIFont systemFontOfSize:kTitleFontSize];
    _wallTitle_Label.textColor = [UIColor whiteColor];
    
    //签名
    _wallSignature_Label=[[UILabel alloc]init];
    _wallSignature_Label.lineBreakMode = NSLineBreakByWordWrapping;
    _wallSignature_Label.font=[UIFont systemFontOfSize:kDetailFontSize];
    _wallSignature_Label.textColor = [UIColor whiteColor];
    [_wallSignature_Label setNumberOfLines:0];
    
    //按钮
    _button = [[UIButton alloc]init];
    [_button setTitle:@"进   入" forState:UIControlStateNormal];
    [_button setTintColor:[UIColor whiteColor]];
    [_button setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
   // [_button addTarget:self action:@selector(wallInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_backgroundView];
    [self addSubview:_bgimageView];
    [self addSubview:_wallTitle_Label];
    [self addSubview:_wallSignature_Label];
    [self addSubview:_button];
    
}


+(instancetype)calloutViewWithMapView:(MKMapView *)mapView{
    static NSString *calloutKey=@"calloutKey1";
    KCCalloutAnnotationView *calloutView=(KCCalloutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:calloutKey];
    if (!calloutView) {
        calloutView=[[KCCalloutAnnotationView alloc]init];
    }
    return calloutView;
}

#pragma mark 当给大头针视图设置大头针模型时可以在此处根据模型设置视图内容
-(void)setAnnotation:(KCCalloutAnnotation *)annotation{
    [super setAnnotation:annotation];
    //根据模型调整布局
    _bgimageView.image = annotation.bgimage;
    _bgimageView.frame = CGRectMake(kSpacing, kSpacing, 250, 250);
    
    _wallTitle_Label.text = annotation.title;
    float titleWidth = 250.0;
    CGSize titleSize = [annotation.title boundingRectWithSize:CGSizeMake(titleWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kTitleFontSize]} context:nil].size;
    float titleX = CGRectGetMaxX(_bgimageView.frame)/2 - titleSize.width/2;
    float titleY = CGRectGetMaxY(_bgimageView.frame)/6;
    _wallTitle_Label.frame = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
    
    _wallSignature_Label.text = annotation.signature;
    float signatureWidth = 220.0;
    CGSize signatureSize = [annotation.signature boundingRectWithSize:CGSizeMake(signatureWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kDetailFontSize]} context:nil].size;
    float signatureX = CGRectGetMaxX(_bgimageView.frame)/2-signatureSize.width/2;
    float signatureY = titleX + titleSize.height;
    _wallSignature_Label.frame = CGRectMake(signatureX, signatureY, signatureSize.width, signatureSize.height);
    
    _button.frame=CGRectMake(_bgimageView.frame.origin.x, _bgimageView.frame.size.height + kSpacing - 44, _bgimageView.frame.size.width, 44);
    
    float backgroundWidth=_bgimageView.frame.size.width+2*kSpacing;
    float backgroundHeight=_bgimageView.frame.size.height+2*kSpacing;
    _backgroundView.frame=CGRectMake(0, 0, backgroundWidth, backgroundHeight);
    self.bounds=CGRectMake(0, 100, backgroundWidth, backgroundHeight+kViewOffset);
    
}
@end