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

@end
