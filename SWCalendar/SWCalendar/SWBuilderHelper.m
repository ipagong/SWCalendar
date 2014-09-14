//
//  SWBuilderHelper.m
//  SWCalendar
//
//  Created by suwan on 2014. 9. 12..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWBuilderHelper.h"

@implementation SWBuilderHelper

+ (id <SWCalendarModelProtocol>)modelWithIndex:(NSInteger)index builder:(SWCalendarBuilder *)builder isVertical:(BOOL)isVertical
{
    if (isVertical == YES) {
        
        return [self modelWithVerticalIndex:index builder:builder];
        
    } else {
        
        return [self modelWithHorizontalIndex:index builder:builder];
        
    }
}

+ (id <SWCalendarModelProtocol>)modelWithVerticalIndex:(NSInteger)index builder:(SWCalendarBuilder *)builder
{
    return [builder modelOfIndex:index];
}

+ (id <SWCalendarModelProtocol>)modelWithHorizontalIndex:(NSInteger)index builder:(SWCalendarBuilder *)builder
{
    SWCalendarDayType dayType = 0;
    NSInteger week = 0;
    
    if (index != 0) {
        dayType = (int)(index / (builder.numberOfCalendarVertical));
        
        week = (int)(index % builder.numberOfCalendarVertical);
    }
    
    id model = [builder modelWithDay:dayType week:week];
    
    NSLog(@"[%d]=> %d,%d, %@",index, dayType, week, model);
    
    return model;
}

@end
