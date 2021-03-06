//
//  WQPlaySound.h
//  WQSound
//
//  Created by 念茜 on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  参考：
//  http://blog.csdn.net/yiyaaixuexi/article/details/7870328
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface WQPlaySound : NSObject
{
    SystemSoundID soundID;
}

/**
 *  @brief  为播放震动效果初始化
 *
 *  @return self
 */
-(id)initForPlayingVibrate;

/**
 *  @brief  为播放系统音效初始化(无需提供音频文件)
 *
 *  @param resourceName 系统音效名称
 *  @param type 系统音效类型
 *
 *  @return self
 */
-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type;

/**
 *  @brief  为播放特定的音频文件初始化（需提供音频文件）
 *
 *  @param filename 音频文件名（加在工程中）
 *
 *  @return self
 */
-(id)initForPlayingSoundEffectWith:(NSString *)filename;

/**
 *  @brief  播放音效
 */
-(void)play;

@end