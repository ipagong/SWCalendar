//
//  SWCalendarBuilder.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 2..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCalendarFactoryProtocol.h"
#import "SWCalendarBuilderProtocol.h"
#import "SWCalendarModelProtocol.h"

@interface SWCalendarBuilder : NSObject <SWCalendarBuilderProtocol>

@property (nonatomic, strong, readonly) NSMutableArray *totalModels;

- (id<SWCalendarModelProtocol>)modelWithDay:(SWCalendarDayType)dayType
                                       week:(NSInteger)week;
- (id<SWCalendarModelProtocol>)modelExceptDecoWithDay:(SWCalendarDayType)dayType
                                                 week:(NSInteger)week;
- (NSInteger)lastDay;
- (NSInteger)numberOfCalendarHorizontal;
- (NSInteger)numberOfCalendarVertical;
- (NSInteger)totalModelCount;
@end
