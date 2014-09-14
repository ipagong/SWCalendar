//
//  SWCalendarBuilderProtocol.h
//  SWCalendar
//
//  Created by suwan on 2014. 9. 12..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCalendarFactoryProtocol.h"

@protocol SWCalendarBuilderProtocol <NSObject>

- (instancetype)initWithModelFactory:(id<SWCalendarFactoryProtocol>)factory;

- (void)setDate:(NSDate *)date;
- (void)reloadModels;

- (id<SWCalendarModelProtocol>)modelOfIndex:(NSInteger)index;

- (NSString *)calendarKey;

- (NSInteger)totalModelCount;
- (NSInteger)numberOfCalendarVertical;
- (NSInteger)numberOfCalendarHorizontal;

@property (nonatomic, strong, readonly) NSMutableArray *totalModels;

@end
