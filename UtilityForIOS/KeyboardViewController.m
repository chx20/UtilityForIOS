/*
 测试隐藏键盘的几种方法
    方法一：通过委托来实现放弃第一响应者
    方法二：给最外层的view添加一个手势响应UITapGestureRecognizer
    方法三：重写touchesBegan
 */


#import "KeyboardViewController.h"

@interface KeyboardViewController ()

@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     方法二：给最外层的view添加一个手势响应UITapGestureRecognizer
     
    //给最外层的view添加一个手势响应UITapGestureRecognizer
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
     
     cancelsTouchesInView为YES,表示当Gesture Recognizers识别到手势后，
     会向hit-test view发送 touchesCancelled:withEvent:消息来取消hit-test view
     对此触摸序列的处理,这样只有Gesture Recognizers能响应此触摸序列，
     hit-test view不再响应。如果为NO,则不发送touchesCancelled:withEvent:
     消息给hit-test view,这样会使Gesture Recognizers和hit-test view同时响应触摸序列。
     */
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [_txtTestField resignFirstResponder];
}

-(void) viewWillAppear:(BOOL)animated {
    
    //注册键盘出现通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidShow:)
                                                 name: UIKeyboardDidShowNotification object:nil];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:)
                                                 name: UIKeyboardDidHideNotification object:nil];
    [super viewWillAppear:animated];
}


-(void) viewWillDisappear:(BOOL)animated {
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidShowNotification object:nil];
    //解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidHideNotification object:nil];
    
    [super viewWillDisappear:animated];
}

-(void) keyboardDidShow: (NSNotification *)notif {
    NSLog(@"键盘打开");
}

-(void) keyboardDidHide: (NSNotification *)notif {
    NSLog(@"键盘关闭");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//方法一：通过委托来实现放弃第一响应者
#pragma mark - UITextField Delegate Method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_txtTestField resignFirstResponder];
    return YES;
}


/**
 方法三：重写touchesBegan
 
 由于UIViewController是继承自UIResponder的，所以可以覆写
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
 这个开始触摸的方法来取消第一响应者
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_txtTestField resignFirstResponder];
}


@end
