//
//  ImagePickerViewController.m
//  UtilityForIOS
//
//  Created by 程红秀 on 2015-4-1.
//  Copyright (c) 2015年 chx20. All rights reserved.
//

#import "ImagePickerViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@import AssetsLibrary;

@interface ImagePickerViewController ()
{
    UIImagePickerController *controller;
}
- (IBAction)btnTest_TouchUP:(id)sender;

@end

@implementation ImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(IBAction)btnCap_TouchUp:(id)sender {
    [controller takePicture];
}

- (IBAction)btnTest_TouchUP:(id)sender {
    
    // 初始化图片选择控制器
    controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;// 设置类型
    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    controller.showsCameraControls = YES;
    
    //添加按钮
    UIButton* btnCap = [UIButton buttonWithType:UIButtonTypeSystem];
    btnCap.frame = CGRectMake(10, 10, 30, 30);
    [btnCap setTitle:@"开始" forState:UIControlStateNormal];
    [btnCap addTarget:self action:@selector(btnCap_TouchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [controller.view addSubview:btnCap];
    
    // 设置所支持的类型，设置只能拍照，或则只能录像，或者两者都可以
    NSString *mtImage = (__bridge NSString*)kUTTypeImage;
    NSString *mtMovie = (__bridge NSString*)kUTTypeMovie;
    NSArray *arrMediaTypes = [NSArray arrayWithObjects:mtImage, mtMovie,nil];
    [controller setMediaTypes:arrMediaTypes];
    
    // 设置录制视频的质量
    [controller setVideoQuality:UIImagePickerControllerQualityTypeHigh];
    
    //设置最长摄像时间
    [controller setVideoMaximumDuration:5.0f]; //单位是秒，如果设置的ssl值小于1，则使用默认值10分钟。
    
    [controller setAllowsEditing:YES];// 设置是否可以管理已经存在的图片或者视频
    [controller setDelegate:self];// 设置代理
    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}


// 保存图片后到相册后，调用的相关方法，查看是否保存成功
- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSLog(@"Picker returned successfully.");
    NSLog(@"%@", info);
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        // 保存图片到相册中
        SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
        UIImageWriteToSavedPhotosAlbum(theImage, self,selectorToCall, NULL);
        
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        // 判断获取类型：视频
        //获取视频文件的url
        NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //创建ALAssetsLibrary对象并将视频保存到媒体库
        // Assets Library 框架包是提供了在应用程序中操作图片和视频的相关功能。相当于一个桥梁，链接了应用程序和多媒体文件。
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        // 将视频保存到相册中
        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL
                                          completionBlock:^(NSURL *assetURL, NSError *error) {
                                              if (!error) {
                                                  NSLog(@"captured video saved with no error.");
                                              }else{
                                                  NSLog(@"error occured while saving the video:%@", error);
                                              }
                                          }];
        
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}









@end
