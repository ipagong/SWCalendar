//
//  SWCalendarConstants.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 30..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#ifndef SWCalendar_SWCalendarConstants_h
#define SWCalendar_SWCalendarConstants_h

typedef enum {
    
    SWCalendarViewScrollDirectionHorizontal = 0,
    SWCalendarViewScrollDirectionVertical
    
} SWCalendarViewScrollDirection;

typedef enum {
    
    SWCalendarDayTypeSunday = 1,
    SWCalendarDayTypeMonday,
    SWCalendarDayTypeTuseday,
    SWCalendarDayTypeWednesday,
    SWCalendarDayTypeThursday,
    SWCalendarDayTypeFriday,
    SWCalendarDayTypeSaturday,
    
} SWCalendarDayType;

#define kSWCalendarDefaultDecoCellKey        @"DefaultDecoCellKey"

#define kSWCalendarDefaultDayCellKey         @"DefaultDayCellKey"
#define kSWCalendarDefaultEmptyDayCellKey    @"DefaultEmptyDayCellKey"

#define kSWCalendarEmptyString          @""
#define kSWCalendarNotChangedValue      -1

#endif
