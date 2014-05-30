//
//  NSDate+SWAddtions.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 28..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "NSDate+SWAddtions.h"

@implementation NSDate (SWAddtions)

- (NSDateComponents *)sw_defaultComponents
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday
                       fromDate:self];
}

- (NSInteger)sw_day
{
    return [self sw_defaultComponents].day;
}

- (NSInteger)sw_month
{
    return [self sw_defaultComponents].month;
}

- (NSInteger)sw_year
{
    return [self sw_defaultComponents].year;
}

- (NSInteger)sw_weakOfMonth
{
    return [self sw_defaultComponents].weekOfMonth;
}

- (NSInteger)sw_weakday
{
    return [self sw_defaultComponents].weekday;
}

- (NSInteger)sw_dateCount
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:[self sw_year]];
    [components setMonth:[self sw_month] + 1];
    [components setDay:0];
    
    return [[[NSCalendar currentCalendar] dateFromComponents:components] sw_day];
}

@end
