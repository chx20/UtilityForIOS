//
//  GestureViewController.h
//  UtilityForIOS
//
//  Created by 程红秀 on 2015-3-30.
//  Copyright (c) 2015年 chx20. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblPan;
@property (weak, nonatomic) IBOutlet UILabel *lblPinch;
@property (weak, nonatomic) IBOutlet UILabel *lblRotate;
@property (weak, nonatomic) IBOutlet UILabel *lblTap;
@property (weak, nonatomic) IBOutlet UILabel *lblLongPress;

- (void)foundTap:(UITapGestureRecognizer *)gesture;
- (void)foundPinch:(UIPinchGestureRecognizer *)gesture;
- (void)foundRotation:(UISwipeGestureRecognizer *)gesture;
- (void)foundSwipe:(UISwipeGestureRecognizer *)gesture;
- (void)foundPan:(UIPanGestureRecognizer *)gesture;
- (void)foundLongPress:(UILongPressGestureRecognizer *)gesture;


@end
