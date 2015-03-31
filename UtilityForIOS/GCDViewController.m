/*
 Grand Central Dispatch 简称（GCD）是苹果公司开发的技术，以优化的应用程序支持多核心处理器
 和其他的对称多处理系统的系统。这建立在任务并行执行的线程池模式的基础上的。它首次发布在Mac 
 OS X 10.6 ，iOS 4及以上也可用。
 设计：
    GCD的工作原理是：让程序平行排队的特定任务，根据可用的处理资源，安排他们在任何可用的处理器核心上执行任务。
 一个任务可以是一个函数(function)或者是一个block。 GCD的底层依然是用线程实现，不过这样可以让程序员不用关注实现的细节。
 GCD中的FIFO队列称为dispatch queue，它可以保证先进来的任务先得到执行
 dispatch queue分为下面三种：
    Serial
        又称为private dispatch queues，同时只执行一个任务。Serial queue通常用于同步访问特定的资源或数据。
        当你创建多个Serial queue时，虽然它们各自是同步执行的，但Serial queue与Serial queue之间是并发执行的。
    Concurrent
        又称为global dispatch queue，可以并发地执行多个任务，但是执行完成的顺序是随机的。
    Main dispatch queue
        它是全局可用的serial queue，它是在应用程序主线程上执行任务的。
 */

#import "GCDViewController.h"

@interface GCDViewController()
@property (weak, nonatomic) IBOutlet UIImageView *imgTest;
- (IBAction)btnDownloadAsync:(id)sender;
- (IBAction)btnGroup_TouchUp:(id)sender;
- (IBAction)btnBarrierTest_TouchUp:(id)sender;
- (IBAction)btnApply_TouchUp:(id)sender;
@end



@implementation GCDViewController


-(void)viewDidLoad {
    self.title = @"GCD功能测试";
}


/*
 dispatch_async
    为了避免界面在处理耗时的操作时卡死，比如读取网络数据，IO,数据库读写等，
    我们会在另外一个线程中处理这些操作，然后通知主线程更新界面。
    用GCD实现这个流程的操作比前面介绍的NSThread  NSOperation的方法都要简单。
 */
- (IBAction)btnDownloadAsync:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL* url = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/9358d109b3de9c82b6acf33f6d81800a18d843b0.jpg"];
        NSData* data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage* image = [[UIImage alloc] initWithData: data ];
        if(data != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                _imgTest.image = image;
            });
        }
    });
}


/* 
 dispatch_barrier_async
        是在前面的任务执行结束后它才执行，而且它后面的任务等它执行完成之后才会执行
 */
- (IBAction)btnBarrierTest_TouchUp:(id)sender {
    dispatch_queue_t queue = dispatch_queue_create("chx20", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"dispatch_async 1 start");
        [NSThread sleepForTimeInterval: 2];
        NSLog(@"dispatch_async 1 end");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"dispatch_async 2 start");
        [NSThread sleepForTimeInterval: 2];
        NSLog(@"dispatch_async 2 end");
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"dispatch_barrier_async");
        [NSThread sleepForTimeInterval:4];
    });
    
    dispatch_async(queue, ^{
        NSLog(@"dispatch_async 3 start");
        [NSThread sleepForTimeInterval: 4];
        NSLog(@"dispatch_async 3 end");
    });
}

/*
 执行某个代码片段N次
 */
- (IBAction)btnApply_TouchUp:(id)sender {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(5, queue, ^(size_t index){
        NSLog(@"dispatch_apply test: %ld", index);
    });
}

/*
 dispatch_group_async可以实现监听一组任务是否完成，完成后得到通知执行其他的操作
 */
- (IBAction)btnGroup_TouchUp:(id)sender {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group1");
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"group2");
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"group3");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"updateUi");
    });  
}
@end













