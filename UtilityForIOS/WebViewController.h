//
//  WebViewController.h
//  UtilityForIOS
//
//  Created by 程红秀 on 2015-3-26.
//  Copyright (c) 2015年 chx20. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *web;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actIndicator;

- (IBAction)btnLoadFromURL_touchUp:(id)sender;
- (IBAction)btnEvalJS_TouchUp:(id)sender;
@end
