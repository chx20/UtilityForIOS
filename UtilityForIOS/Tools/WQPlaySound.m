/*
 调用方法步骤：
 1.加入AudioToolbox.framework到工程中
 2.调用WQPlaySound工具类
 2.1震动
        WQPlaySound *sound = [[WQPlaySound alloc]initForPlayingVibrate];
        [sound play];
 
 2.2系统音效，以Tock为例
        WQPlaySound *sound = [[WQPlaySound alloc]initForPlayingSystemSoundEffectWith:@"Tock" ofType:@"aiff"];
        [sound play];
 
 2.3自定义音效，将tap.aif音频文件加入到工程
        WQPlaySound *sound = [[WQPlaySound alloc]initForPlayingSoundEffectWith:@"tap.aif"];
        [sound play];
 
 
 apple系统默认声音名称说明：（此说明来自于http://bbs.weiphone.com/read-htm-tid-6262661.html）
 1.声音格式是MP3或m4r的需要转成caf格式（可先转成aif , aiff，然后修改后缀）
 2.路径在/System/Library/Audio/UISounds 里，需要更改的可以根据以下列表进行替换
 3详细列表：
 信息
 ReceivedMessage.caf--收到信息，仅在短信界面打开时播放。
 sms-received1.caf-------三全音
 sms-received2.caf-------管钟琴
 sms-received3.caf-------玻璃
 sms-received4.caf-------圆号
 sms-received5.caf-------铃声
 sms-received6.caf-------电子乐
 SentMessage.caf--------发送信息
 
 邮件
 mail-sent.caf----发送邮件
 new-mail.caf-----收到新邮件
 
 电话
 dtmf-0.caf----------拨号面板0按键
 dtmf-1.caf----------拨号面板1按键
 dtmf-2.caf----------拨号面板2按键
 dtmf-3.caf----------拨号面板3按键
 dtmf-4.caf----------拨号面板4按键
 dtmf-5.caf----------拨号面板5按键
 dtmf-6.caf----------拨号面板6按键
 dtmf-7.caf----------拨号面板7按键
 dtmf-8.caf----------拨号面板8按键
 dtmf-9.caf----------拨号面板9按键
 dtmf-pound.caf---拨号面板＃按键
 dtmf-star.caf------拨号面板*按键
 Voicemail.caf-----新语音邮件
 
 输入设备声音提示
 Tock.caf-----------------------点击键盘
 begin_record.caf-----------开始录音
 begin_video_record.caf--开始录像
 photoShutter.caf------------快门声
 end_record.caf--------------结束录音
 end_video_record.caf-----结束录像
 
 其他
 beep-beep.caf--充电、注销及连接电脑
 lock.caf------------锁定手机
 shake.caf---------“这个还没搞清楚”
 unlock.caf--------滑动解锁
 low_power.caf--低电量提示
 
 语音控制
 jbl_ambiguous.caf--找到多个匹配
 jbl_begin.caf------等待用户的输入
 jbl_cancel.caf-----取消
 jbl_confirm.caf----执行
 jbl_no_match.caf---没有找到匹配
 
 日历
 alarm.caf--日历提醒
 
 iPod Touch 1G
 sq_alarm.caf 
 sq_beep-beep.caf 
 sq_lock.caf 
 sq_tock.caf
 
 */

#import "WQPlaySound.h"

@implementation WQPlaySound

-(id)initForPlayingVibrate
{
    self = [super init];
    if (self) {
        soundID = kSystemSoundID_Vibrate;
    }
    return self;
}

-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
        if (path) {
            SystemSoundID theSoundID;
            OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            if (error == kAudioServicesNoError) {
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        }
        
    }
    return self;
}

-(id)initForPlayingSoundEffectWith:(NSString *)filename
{
    self = [super init];
    if (self) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (fileURL != nil)
        {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError){
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        }
    }
    return self;
}

-(void)play
{
    AudioServicesPlaySystemSound(soundID);
}

-(void)dealloc
{
    AudioServicesDisposeSystemSoundID(soundID);
}
@end