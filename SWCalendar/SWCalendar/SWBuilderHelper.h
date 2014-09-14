//
//  SWBuilderHelper.h
//  SWCalendar
//
//  Created by suwan on 2014. 9. 12..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCalendarBuilder.h"

@interface SWBuilderHelper : NSObject

+ (id <SWCalendarModelProtocol>)modelWithIndex:(NSInteger)index
                                       builder:(SWCalendarBuilder *)builder
                                    isVertical:(BOOL)isVertical;

+ (id <SWCalendarModelProtocol>)modelWithVerticalIndex:(NSInteger)index
                                               builder:(SWCalendarBuilder *)builder;

+ (id <SWCalendarModelProtocol>)modelWithHorizontalIndex:(NSInteger)index
                                                 builder:(SWCalendarBuilder *)builder;
@end
