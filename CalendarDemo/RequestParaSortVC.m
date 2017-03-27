//
//  RequestParaSortVC.m
//  CalendarDemo
//
//  Created by admin on 17/3/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "RequestParaSortVC.h"

@interface RequestParaSortVC ()

@end

@implementation RequestParaSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSArray *arr = @[@"fjhsf",@"wert",@"fdg",@"asd",@"fs gds",@"Bfd sd",@"ref",@"hjk"];
//    
//    //忽略大小写的首字母自然排序（a-zA-Z,若首字母相同依次比较第二个字母）
//    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
//    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
//    NSComparator sort = ^(NSString *obj1,NSString *obj2){
//        NSRange range = NSMakeRange(0,obj1.length);
//        return [obj1 compare:obj2 options:comparisonOptions range:range];
//    };
//    
//    NSArray *resultArray = [arr sortedArrayUsingComparator:sort];
//    
//    NSLog(@"字符串数组排序结果%@",resultArray);
//    
//    return;
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"1" forKey:@"Akey1"];
    [dict setObject:@"2" forKey:@"bkey2"];
    [dict setObject:@"3" forKey:@"gkey3"];
    [dict setObject:@"4" forKey:@"Dkey4"];
    
    [self stringWithDict:dict];
    return;
    
    for (NSString *str in [dict allKeys]) {
        NSLog(@"key == %@",str);
    }
    
    NSArray *keys = [dict allKeys];
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *sortedArray = [keys sortedArrayUsingComparator:sort];
    NSLog(@"字符串数组排序结果%@",sortedArray);

    
    for (NSString *categoryId in sortedArray) {
        NSLog(@"%@ : %@", categoryId,[dict objectForKey:categoryId]);
    }
    
    
}



-(NSDictionary*)stringWithDict:(NSDictionary*)dict{
    NSArray*keys = [dict allKeys];
    
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *sortedArray = [keys sortedArrayUsingComparator:sort];
    NSLog(@"字符串数组排序结果%@",sortedArray);
    
    NSMutableDictionary *sortedDic = [[NSMutableDictionary alloc]init];
    for (NSString *categoryId in sortedArray) {
        NSLog(@"%@ : %@", categoryId,[dict objectForKey:categoryId]);
        [sortedDic setObject:[dict objectForKey:categoryId] forKey:categoryId];
    }
    
    NSLog(@"sortedDic-------%@",sortedDic);
    return sortedDic;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
