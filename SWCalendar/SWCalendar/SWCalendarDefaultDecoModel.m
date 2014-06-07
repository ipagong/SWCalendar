//
//  SWCalendarDefaultDecoModel.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 4..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarDefaultDecoModel.h"
#import "SWCalendarConstants.h"

@implementation SWCalendarDefaultDecoModel

- (NSString *)cellKey
{
    return kSWCalendarDefaultDecoCellKey;
}

- (Class)cellClazz
{
    return NSClassFromString(@"SWCalendarSimpleDecoCell");
}

- (NSString *)title
{
    switch (self.dayType) {
        case SWCalendarDayTypeSunday:
            return @"SUN";
            break;
        case SWCalendarDayTypeMonday:
            return @"MON";
            break;
        case SWCalendarDayTypeTuseday:
            return @"TUE";
            break;

        case SWCalendarDayTypeWednesday:
            return @"WED";
            break;

        case SWCalendarDayTypeThursday:
            return @"THU";
            break;

        case SWCalendarDayTypeFriday:
            return @"FRI";
            break;

        case SWCalendarDayTypeSaturday:
            return @"SAT";
            break;
        default:
            
            break;
    }
    
    return kSWCalendarEmptyString;
}

- (NSString *)subTitle
{
    switch (self.dayType) {
        case SWCalendarDayTypeSunday:
            return @"SUNDAY";
            break;
        case SWCalendarDayTypeMonday:
            return @"MONDAY";
            break;
        case SWCalendarDayTypeTuseday:
            return @"TUSEDAY";
            break;
            
        case SWCalendarDayTypeWednesday:
            return @"WEDNESDAY";
            break;
            
        case SWCalendarDayTypeThursday:
            return @"THURSDAY";
            break;
            
        case SWCalendarDayTypeFriday:
            return @"FRIDAY";
            break;
            
        case SWCalendarDayTypeSaturday:
            return @"SATURDAY";
            break;
        default:
            break;
    }
    
    return kSWCalendarEmptyString;
}

@end
