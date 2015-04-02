//
//  FunctionTableViewController.m
//  UtilityForIOS
//
//  Created by 程红秀 on 2015-4-1.
//  Copyright (c) 2015年 chx20. All rights reserved.
//

#import "FunctionTableViewController.h"
#import "KeyboardViewController.h"
#import "WebViewController.h"
#import "GestureViewController.h"
#import "GCDViewController.h"

@interface FunctionTableViewController ()

@end

@implementation FunctionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger nSection = indexPath.section;
    NSInteger nRow = indexPath.row;
    
    NSString* viewControllerId = nil;
    if(nSection == 0) {
        switch (nRow) {
            case 0: viewControllerId = @"vc_keyboard"; break;
            case 1: viewControllerId = @"vc_web"; break;
            case 2: viewControllerId = @"vc_gesture"; break;
            case 3: viewControllerId = @"vc_gcd"; break;
            case 4: viewControllerId = @"vc_imagepicker"; break;
            case 5: viewControllerId = @"vc_qrcode"; break;
            default: break;
        }
    }
    
    if(viewControllerId !=nil){
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        id viewController = [storyBoard instantiateViewControllerWithIdentifier:viewControllerId];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
