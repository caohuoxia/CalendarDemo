//
//  ViewController.m
//  CalendarDemo
//
//  Created by admin on 17/3/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import "FSCalendar.h"
#import "BlockCycleRef.h"


#define kContainerFrame (CGRectMake(0, CGRectGetMaxY(calendar.frame), CGRectGetWidth(self.view.frame), 50))

NS_ASSUME_NONNULL_BEGIN

@interface ViewController()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (strong, nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) NSCalendar *gregorian;

@property (strong, nonatomic) NSDictionary *fillDefaultColors;
@property (strong, nonatomic) NSDateFormatter *dateFormatter1;

- (void)nextClicked:(id)sender;
- (void)prevClicked:(id)sender;

@end

NS_ASSUME_NONNULL_END

@implementation ViewController

- (NSDateFormatter *)dateFormatter1{
    if (!_dateFormatter1) {
        //注意默认的ViewController是不会调用init方法，所以这个初始化最好不要放在init里面
        _dateFormatter1 = [[NSDateFormatter alloc] init];
        _dateFormatter1.dateFormat = @"yyyy/MM/dd";
    }
    
    return _dateFormatter1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 400 for iPad and 300 for iPhone
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 400 : 300;
    self.calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), CGRectGetWidth(self.view.frame), height)];
    self.calendar.backgroundColor = [UIColor whiteColor];
    self.calendar.dataSource = self;
    self.calendar.delegate = self;
    //占位日期显示设置，none的话就是空白，不显示占位日期
    self.calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendar.currentPage = [self.dateFormatter1 dateFromString:@"2015/10/08"];
    //若不设置这个，默认情况下星期是从周日开始的。
    //如下设置则从周一开始
    self.calendar.firstWeekday = 2;
    self.calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    [self.view addSubview:self.calendar];
    
    self.calendar.appearance.separators = FSCalendarSeparatorNone;
    self.calendar.swipeToChooseGesture.enabled = YES;
    
    self.fillDefaultColors = @{@"2015/10/08":[UIColor purpleColor],
                               @"2015/10/06":[UIColor greenColor],
                               @"2015/10/18":[UIColor cyanColor],
                               @"2015/10/22":[UIColor yellowColor],
                               @"2015/11/08":[UIColor purpleColor],
                               @"2015/11/06":[UIColor greenColor],
                               @"2015/11/18":[UIColor cyanColor],
                               @"2015/11/22":[UIColor yellowColor],
                               @"2015/12/08":[UIColor purpleColor],
                               @"2015/12/06":[UIColor greenColor],
                               @"2015/12/18":[UIColor cyanColor],
                               @"2015/12/22":[UIColor magentaColor]};
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //今天按钮
    UIBarButtonItem *todayItem = [[UIBarButtonItem alloc] initWithTitle:@"TODAY" style:UIBarButtonItemStylePlain target:self action:@selector(todayItemClicked:)];
    self.navigationItem.rightBarButtonItem = todayItem;
}

#pragma mark - Target actions

- (void)todayItemClicked:(id)sender
{
    BlockCycleRef *vc = [[BlockCycleRef alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    
    //注意最大的日期范围大于今天，否则回到今天 是不会成功的。
//    [self.calendar setCurrentPage:[NSDate date] animated:NO];
}

//注意当前日历，起始日历还有结束日历设置 要用同一个dateFormatter来设置才会起效
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter1 dateFromString:@"2015/10/08"];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter1 dateFromString:@"2017/05/08"];
}


#pragma mark - <FSCalendarDelegateAppearance>

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter1 stringFromDate:date];
    if ([_fillDefaultColors.allKeys containsObject:key]) {
        return _fillDefaultColors[key];
    }
    return nil;
}


#pragma mark - <FSCalendarDelegate>
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition;{
    NSLog(@"didSelectDate");
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
}

#pragma mark - Target action

- (void)nextClicked:(id)sender
{
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:self.calendar.currentPage options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}

- (void)prevClicked:(id)sender
{
    NSDate *prevMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:self.calendar.currentPage options:0];
    [self.calendar setCurrentPage:prevMonth animated:YES];
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

@end

