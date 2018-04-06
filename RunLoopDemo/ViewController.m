//
//  ViewController.m
//  RunLoopDemo
//
//  Created by 新闻 on 2018/3/30.
//  Copyright © 2018年 Lvmama. All rights reserved.
//

#import "ViewController.h"
#import "FN_Thread.h"

@interface ViewController ()

@property (nonatomic, strong) dispatch_source_t timer;
//@property (nonatomic, strong) FN_Thread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    FN_Thread *thread = [[FN_Thread alloc] initWithBlock:^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
        NSLog(@"111");
//        while (true) {
//        }
    }];
    [thread start];
//    _thread = thread;
     */
    
    [self addOberser];
    [self GCDTimer];
}

- (void)timerMethod {
    NSLog(@"222");
    [NSThread sleepForTimeInterval:2.0];
    static int a = 0;
    a++;
    NSLog(@"a=%zd",a);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"thread=%@",_thread);
//    [_thread start];
    
    FN_Thread *thread = [[FN_Thread alloc] initWithBlock:^{
        NSLog(@"touch");
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    }];
    [thread start];
    [self performSelector:@selector(performMethod) onThread:thread withObject:nil waitUntilDone:NO];
}

- (void)performMethod {
    NSLog(@"performMethod");
}

- (void)addOberser {
    // 创建observer
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"activity = %zd", activity);
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
}

int count = 0;
- (void)GCDTimer {
    // 获得队列
    dispatch_queue_t queue = dispatch_get_main_queue(); // dispatch_get_global_queue(0, 0);
    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.timer = timer;
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(timer, start, interval, 0);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"count=%zd",count);
        count++;
    });
    // 启动定时器
    dispatch_resume(timer);
    // 取消定时器
    //dispatch_cancel(self.timer);
}

@end
