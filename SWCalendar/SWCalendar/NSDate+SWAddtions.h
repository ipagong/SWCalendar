//
//  NSDate+SWAddtions.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 28..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SWAddtions)

+ (NSDate *)sw_dateWithYear:(NSInteger)year
                      month:(NSInteger)month
                        day:(NSInteger)day;

- (NSDate *)sw_setDateWithYear:(NSInteger)year
                         month:(NSInteger)month
                           day:(NSInteger)day;


- (NSInteger)sw_day;
- (NSInteger)sw_month;
- (NSInteger)sw_year;

- (NSInteger)sw_weakOfMonth;
- (NSInteger)sw_weakday;

- (NSInteger)sw_dateCount;
- (NSInteger)sw_countWeekOfMonth;

- (NSDate *)sw_lastDateOfCurrentMonth;
- (NSDate *)sw_firstDateOfCurrentMonth;
- (NSDate *)sw_modifiedDateWithYear:(NSInteger)addYear
                              month:(NSInteger)addMonth
                                day:(NSInteger)addDay;

- (NSString *)sw_calendarKey;

@end
