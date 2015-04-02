#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Utils.h"
#import "WQPlaySound.h"

@interface UtilityForIOSTests : XCTestCase

@end

@implementation UtilityForIOSTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}


- (void)test_Utility_applicationDirectory {
    NSString* strDoc = [Utils applicationDocumentsDirectory];
    /*
     NSLog(strDoc);
     在Xcode 4.2(iOS 5)之后，貌似苹果更新的编译器，出了支持ARC的Apple LLVM compiler 3.0。
     然后我发现每次编译，以前的这些输出都会产生一个warning(警告，黄色三角形)。
     在StackOverflow和iPhone Dev SDK查找相关答案之后，发现在最新版的编译器里面NSLog为了安全，
     只接受格式化的字符串，因为NSLog底层也是用printf来格式化输出的。
     所以上面的写法都会给出警告
     */
    NSLog(@"%@", strDoc);
    
    NSString* strFile = [Utils applicationDocumentsDirectoryFile:@"test.xml"];
    NSLog(@"%@", strFile);
    
    
    NSString* strCache = [Utils applicationCachesDirectory];
    NSLog(@"%@", strCache);
}


- (void)test_Utility_date {
    NSString* strNow = [Utils getCurrentDate];
    NSLog(@"%@", strNow);
}

- (void)test_Bundle {
    NSBundle* bundle = [NSBundle mainBundle];
    NSLog(@"bundlePath: %@", [bundle bundlePath]);
    NSLog(@"resourcePath: %@", [bundle resourcePath]);
    NSLog(@"executablePath: %@", [bundle executablePath]);
    
    NSString* strWebFile = [Utils applicationBundleResourceFile:@"WebViewTest.html"];
    NSLog(@"Web: %@", strWebFile);
}

- (void)test_WQPlaySound {
    
    //振动
    WQPlaySound *sound = [[WQPlaySound alloc]initForPlayingVibrate];
    [sound play];
    
    //系统音效，以Tock为例
    WQPlaySound *sound1 = [[WQPlaySound alloc]initForPlayingSystemSoundEffectWith:@"Tock" ofType:@"aiff"];
    [sound1 play];
    
    WQPlaySound *sound2 = [[WQPlaySound alloc]initForPlayingSoundEffectWith:@"tap.aif"];
    [sound2 play];
}


@end
