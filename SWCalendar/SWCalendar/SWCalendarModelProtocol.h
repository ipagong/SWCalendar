//
//  SWCalendarModelProtocol.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 2..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCalendarConstants.h"

@protocol SWCalendarModelProtocol <NSObject>

- (NSString *)cellKey;
- (Class)cellClazz;

- (NSString *)title;
- (NSString *)subTitle;

- (BOOL)enable;

@property (nonatomic, assign) SWCalendarDayType dayType;

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;

@property (nonatomic, assign) BOOL isOtherMonth;


@end
