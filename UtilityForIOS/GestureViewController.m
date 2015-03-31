//
//  GestureViewController.m
//  UtilityForIOS
//
//  Created by 程红秀 on 2015-3-30.
//  Copyright (c) 2015年 chx20. All rights reserved.
//

#import "GestureViewController.h"
#import "ChxTools.h"


@interface GestureViewController() {
    NSString* _imageName;
}
@end

@implementation GestureViewController

- (void)addGestureRecognizerToView:(UIView*)view {
    //点击手势
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundTap:)];
    tap.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tap];
    
    //缩放手势
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(foundPinch:)];
    [view addGestureRecognizer:pinch];
    
    //旋转手势
    UIRotationGestureRecognizer* rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(foundRotation:)];
    [view addGestureRecognizer:rotate];

    //平移手势
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(foundPan:)];
    [view addGestureRecognizer:pan];
    
    //长按手势
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(foundLongPress:)];
    [view addGestureRecognizer:longPress];    
}

-(void)viewDidLoad{
    
    //imageview默认为不可交互的，且不支持多点触控，需要在storyboard中勾选这两项
    //或者通过代码设置
    [_img setUserInteractionEnabled:YES];
    [_img setMultipleTouchEnabled:YES];
    
    [self addGestureRecognizerToView:_img];
    [_img setImage:[UIImage imageNamed:@"小姑娘.jpg"]];
    _imageName = @"xiao";
}

- (void)foundTap:(UITapGestureRecognizer *)gesture {
    
    if([_imageName isEqualToString:@"xiao"]) {
        [_img setImage:[UIImage imageNamed:@"美女.jpg" ]];
        _imageName = @"mei";
    }
    else {
        [_img setImage:[UIImage imageNamed:@"小姑娘.jpg" ]];
        _imageName = @"xiao";
    }
        
    return;
}

- (void)foundPinch:(UIPinchGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, gesture.scale, gesture.scale);
        gesture.scale = 1;
    }
}

- (void)foundRotation:(UIRotationGestureRecognizer *)gesture {
    //旋转的弧度：gesture.rotation
    NSLog(@"旋转事件，旋转的弧度为:%1f",gesture.rotation);
    UIView *view = gesture.view;
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, gesture.rotation);
        
        //将旋转的弧度清零
        //（注意不是将图片旋转的弧度清零，而是将当前手指旋转的弧度清零）
        [gesture setRotation:0];
    }
}

- (void)foundSwipe:(UISwipeGestureRecognizer *)gesture {
}

- (void)foundPan:(UIPanGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [gesture setTranslation:CGPointZero inView:view.superview];
    }
}

- (void)foundLongPress:(UILongPressGestureRecognizer *)gesture {
}
@end
