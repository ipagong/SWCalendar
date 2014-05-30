//
//  NSDate+SWAddtions.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 28..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SWAddtions)

- (NSInteger)sw_day;
- (NSInteger)sw_month;
- (NSInteger)sw_year;

- (NSInteger)sw_weakOfMonth;
- (NSInteger)sw_weakday;

- (NSInteger)sw_dateCount;

@end
