//
//  SWCalendarBuilder.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 2..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCalendarFactoryProtocol.h"



@interface SWCalendarBuilder : NSObject

- (instancetype)initWithModelFactory:(id<SWCalendarFactoryProtocol>)factory;

- (void)setDate:(NSDate *)date;
- (void)reloadModels;

- (id<SWCalendarModelProtocol>)modelOfIndex:(NSInteger)index;

- (NSInteger)totalModelCount;
- (NSInteger)numberOfCalendarVertical;
- (NSInteger)numberOfCalendarHorizontal;

@property (nonatomic, strong, readonly) NSMutableArray *totalModels;

@end
