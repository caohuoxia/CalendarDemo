//
//  BlockCycleRef.m
//  CalendarDemo
//
//  Created by admin on 17/3/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BlockCycleRef.h"

typedef void(^Block)(void);

@interface BlockCycleRef ()
@property(copy, nonatomic)Block myblock;
@end

@implementation BlockCycleRef

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myblock();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"no cycle retain");
}
- (id)init
{
    self = [super init];
    if (self) {
        
//#if TestCycleRetainCase1
        //会循环引用
//        self.myblock = ^{
//            
//            [self doSomething];
//        };
//#elif TestCycleRetainCase2
//        
//        //会循环引用
//        __block BlockCycleRef *weakSelf = self;
//        self.myblock = ^{
//            
//            [weakSelf doSomething];
//        };
//        
//#elif TestCycleRetainCase3
//        
        //不会循环引用
        __weak BlockCycleRef *weakSelf = self;
        self.myblock = ^{
            
            [weakSelf doSomething];
        };
//
//#elif TestCycleRetainCase4
//        
//        //不会循环引用
//        __unsafe_unretained BlockCycleRef *weakSelf = self;
//        self.myblock = ^{
//            
//            [weakSelf doSomething];
//        };
//        
//#endif
        NSLog(@"myblock is %@", self.myblock);
    }
    
    return self;
}
- (void)doSomething
{
    NSLog(@"do Something");
}

@end
