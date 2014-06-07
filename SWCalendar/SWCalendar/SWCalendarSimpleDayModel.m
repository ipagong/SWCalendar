//
//  SWCalendarSimpleDayModel.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 4..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarSimpleDayModel.h"
#import "SWCalendarConstants.h"

@implementation SWCalendarSimpleDayModel 

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.year  = kSWCalendarNotChangedValue;
        self.month = kSWCalendarNotChangedValue;
        self.day   = kSWCalendarNotChangedValue;
    }
    return self;
}

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
    return kSWCalendarEmptyString;
}

- (NSString *)subTitle
{
    return kSWCalendarEmptyString;
}

@end
