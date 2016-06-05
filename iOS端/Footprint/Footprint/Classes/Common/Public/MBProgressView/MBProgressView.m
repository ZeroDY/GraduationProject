//
//  MBProgressView.m
//  EnjoyPublic
//
//  Created by ONCE on 12-11-9.
//
//

#import "MBProgressView.h"


@implementation MBProgressView
@synthesize mbProgressHUD;

static MBProgressView *mbProgressView = nil;

- (id)init{
    self = [super init];
    if (self) {
//        [self setBackgroundColor:[UIColor clearColor]];
//        [self showProgressHUD:self title:title];
//        [self.superview addSubview:self];
//        [self setFrame:self.superview.frame];
    }
    return self;
}

+(MBProgressView*)shareMBProgressView{
    if(mbProgressView==nil){
        mbProgressView = [[MBProgressView alloc]init];
    }
    return mbProgressView;
}


-(void)showProgressHUD:(UIView*)theView title:(NSString*)theTitle{
    mbProgressHUD = [[MBProgressHUD alloc] initWithView:theView];
    [self addSubview:mbProgressHUD];
    [self bringSubviewToFront:mbProgressHUD];
    mbProgressHUD.delegate = self;
    mbProgressHUD.labelText = theTitle;
    [mbProgressHUD show:YES];
    [mbProgressHUD setUserInteractionEnabled:YES];//最后修改这个部分
    [self setBackgroundColor:[UIColor clearColor]];
//    [self showProgressHUD:self title:title];
    [theView addSubview:self];
    [self setFrame:CGRectMake(0, -60, theView.frame.size.width, theView.frame.size.height)];
}


-(void)dissMissProgressHUD{
    if (mbProgressHUD){
        [mbProgressHUD removeFromSuperview];
        mbProgressHUD = nil;
    }
    [self removeFromSuperview];
}


- (void)hudWasHidden:(MBProgressHUD *)hud{
    NSLog(@"Hud: %@", hud);
    [mbProgressHUD removeFromSuperview];
    mbProgressHUD = nil;
    [self removeFromSuperview];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
