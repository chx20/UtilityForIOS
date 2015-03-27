//
//  WebViewController.m
//  UtilityForIOS
//
//  Created by 程红秀 on 2015-3-26.
//  Copyright (c) 2015年 chx20. All rights reserved.
//

#import "WebViewController.h"
#import "ChxTools.h"
#import "NSString+URLEncoding.h"
#import <Foundation/NSJSONSerialization.h>

@interface WebViewController ()

@end

@implementation WebViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    _web.delegate = self;
    _actIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnLoadFromURL_touchUp:(id)sender {
    NSURL* url = [[NSURL alloc] initWithString:@"http://www.163.com"];
    NSURLRequest* urlReq = [NSURLRequest requestWithURL:url];
    [_web loadRequest:urlReq];
}

- (IBAction)btnEvalJS_TouchUp:(id)sender {
    NSString* webFile = [ChxTools applicationBundleResourceFile:@"WebViewTest.html"];
    NSURL* url = [[NSURL alloc] initWithString:webFile];
    NSURLRequest* urlReq = [NSURLRequest requestWithURL:url];
    [_web loadRequest:urlReq];
}


#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"webView:shouldStartLoadWithRequest:navigationType:");
    NSString *strURL = request.URL.lastPathComponent;
    NSLog(@"URL: %@", strURL);
    
    NSString* actionType = request.URL.host;
    NSString* scheme = request.URL.scheme;
    NSString* fragment = [request.URL.fragment URLDecodedString];
    NSData* responseData = [fragment dataUsingEncoding:NSUTF8StringEncoding];
    
    if([scheme isEqualToString:@"gap"]) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"title: %@ , message: %@",[json objectForKey:@"title"], [json objectForKey:@"message"] );
        return NO;
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    _actIndicator.hidden = NO;
    [_actIndicator startAnimating];
    NSLog(@"webViewDidStartLoad");

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    _actIndicator.hidden = YES;
    [_actIndicator stopAnimating];
    NSLog(@"webViewDidFinishLoad");
    
    NSString *strURL = webView.request.URL.lastPathComponent;
    if([strURL isEqual:@"WebViewTest.html"]) {
        NSString* jsCode = [NSString stringWithFormat:@"setBackColor()"];
        NSString* str = [_web stringByEvaluatingJavaScriptFromString:jsCode];
        NSLog(@"Result: %@", str);
    }
 
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    _actIndicator.hidden = YES;
    [_actIndicator stopAnimating];
    NSLog(@"webView:didFailLoadWithError");
}



@end
