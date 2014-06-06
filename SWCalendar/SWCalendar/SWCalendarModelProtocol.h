//
//  SWCalendarModelProtocol.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 2..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    SWCalendarDayTypeSunday = 1,
    SWCalendarDayTypeMonday,
    SWCalendarDayTypeTuseday,
    SWCalendarDayTypeWednesday,
    SWCalendarDayTypeThursday,
    SWCalendarDayTypeFriday,
    SWCalendarDayTypeSaturday,
    
} SWCalendarDayType;

@protocol SWCalendarModelProtocol <NSObject>

- (NSString *)cellKey;

- (NSString *)title;
- (NSString *)subTitle;

@property (nonatomic, assign) SWCalendarDayType dayType;

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;

@property (nonatomic, assign) BOOL isOtherMonth;

@end
