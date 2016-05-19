//
//  testUnitTestTests.m
//  testUnitTestTests
//
//  Created by Jason on 23/12/12.
//  Copyright (c) 2012 Jason. All rights reserved.
//

#import "QCUnitTest.h"

@implementation QCUnitTest

//setUp和tearDown是一对
//一般会先进入setUp初始化测试环境，随后跑一个testXXX单元测试函数，跑完后最后执行tearDown收尾
//所以通常来说，有几个单元测试函数，setUp和tearDown这对方法就运行几次。
- (void)setUp {
    [super setUp];
    
    SAFE_RELEASE(_testViewController)
    _testViewController = [[QCViewController alloc] initWithNibName:@"QCViewController"
                                                             bundle:nil];
}

- (void)tearDown
{
    SAFE_RELEASE(_testViewController)
    [super tearDown];
}

//加法的单元测试
- (void)testAddFunction {
    STAssertNotNil(_testViewController, @"ViewController instance alloc failed.");

    NSUInteger result = [_testViewController add:11
                                        toNumber:22];

    STAssertTrue(result == 33, @"Plus missed.");
}

//乘法的单元测试
- (void)testMultiplyFunction {
    STAssertNotNil(_testViewController, @"ViewController instance alloc failed.");

    NSUInteger result = [_testViewController multiply:10
                                             toNumber:20];

    STAssertTrue(result == 200, @"Multiply missed.");
}

- (void)testAnimation{
    STAssertNotNil(_testViewController, @"ViewController instance alloc failed.");
    
    //消息循环结束与否的依据
    __block BOOL    isFinishAnimation = NO;
    
    //回调函数
    _testViewController.completionBlock = ^(){
        STAssertTrue(_testViewController.animationButton.center.x == _testViewController.view.center.x, @"Animation missed.");
        
        isFinishAnimation = YES;
    };
    
    //让界面加载出来
    if (_testViewController.view) {
        //执行单元测试的对象函数
        [_testViewController actAnimateButton:_testViewController.animationButton];
    }
    
    //消息循环
    while(isFinishAnimation == NO) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate distantFuture]];
    }
}


@end
