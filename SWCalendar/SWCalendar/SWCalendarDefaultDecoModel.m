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
            return @"일";
            break;
        case SWCalendarDayTypeMonday:
            return @"월";
            break;
        case SWCalendarDayTypeTuseday:
            return @"화";
            break;

        case SWCalendarDayTypeWednesday:
            return @"수";
            break;

        case SWCalendarDayTypeThursday:
            return @"목";
            break;

        case SWCalendarDayTypeFriday:
            return @"금";
            break;

        case SWCalendarDayTypeSaturday:
            return @"토";
            break;
        default:
            
            break;
    }
    
    return kSWCalendarEmptyString;
}

- (NSString *)subTitle
{
//    switch (self.dayType) {
//        case SWCalendarDayTypeSunday:
//            return @"SUNDAY";
//            break;
//        case SWCalendarDayTypeMonday:
//            return @"MONDAY";
//            break;
//        case SWCalendarDayTypeTuseday:
//            return @"TUSEDAY";
//            break;
//            
//        case SWCalendarDayTypeWednesday:
//            return @"WEDNESDAY";
//            break;
//            
//        case SWCalendarDayTypeThursday:
//            return @"THURSDAY";
//            break;
//            
//        case SWCalendarDayTypeFriday:
//            return @"FRIDAY";
//            break;
//            
//        case SWCalendarDayTypeSaturday:
//            return @"SATURDAY";
//            break;
//        default:
//            break;
//    }
//    
    return kSWCalendarEmptyString;
}

- (BOOL)enable
{
    return NO;
}

@end
