//
//  SWCalendarDefaultDayModel.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 4..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarDefaultDayModel.h"
#import "SWCalendarConstants.h"

@implementation SWCalendarDefaultDayModel

- (NSString *)cellKey
{
    return kSWCalendarDefaultDayCellKey;
}

- (Class)cellClazz
{
    return NSClassFromString(@"SWCalendarSimpleDayCell");
}

- (NSString *)title
{
    if (self.day == kSWCalendarNotChangedValue) {
        
        return kSWCalendarEmptyString;
        
    }
    
    return [NSString stringWithFormat:@"%02d", self.day];
}

- (NSString *)subTitle
{
    return kSWCalendarEmptyString;
}

@end
