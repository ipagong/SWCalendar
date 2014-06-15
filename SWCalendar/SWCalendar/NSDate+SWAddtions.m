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
    
    NSCalendarUnit calendarUnit =
    NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday;
    
    return [calendar components:calendarUnit
                       fromDate:self];
}

+ (NSDate *)sw_dateWithYear:(NSInteger)year
                      month:(NSInteger)month
                        day:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit calendarUnit =
    NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday;
    
    NSDateComponents *components = [calendar components:calendarUnit fromDate:[NSDate date]];
    
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)sw_setDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDateComponents *components = [self sw_defaultComponents];
    
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
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
    return [[self sw_setDateWithYear:[self sw_year] month:[self sw_month] + 1 day:0] sw_day];
}

- (NSInteger)sw_countWeekOfMonth
{
    NSInteger year  = [self sw_year];
    NSInteger month = [self sw_month];
    
    return [[self sw_setDateWithYear:year month:month day:0] sw_weakOfMonth];
}

- (NSDate *)sw_lastDateOfCurrentMonth
{
    NSInteger year  = [self sw_year];
    NSInteger month = [self sw_month];
    NSInteger day   = [self sw_dateCount];
    
    return [self sw_setDateWithYear:year month:month day:day];
}

- (NSDate *)sw_firstDateOfCurrentMonth
{
    NSInteger year  = [self sw_year];
    NSInteger month = [self sw_month];
    NSInteger day   = 1;
    
    return [self sw_setDateWithYear:year month:month day:day];
}

- (NSDate *)sw_modifiedDateWithYear:(NSInteger)addYear
                              month:(NSInteger)addMonth
                                day:(NSInteger)addDay
{
    NSInteger year  = [self sw_year]  + addYear;
    NSInteger month = [self sw_month] + addMonth;
    NSInteger day   = [self sw_day]   + addDay;
    
    return [self sw_setDateWithYear:year month:month day:day];
}

- (NSString *)sw_calendarKey
{
    return [NSString stringWithFormat:@"%d-%02d", [self sw_year], [self sw_month]];
}

@end
