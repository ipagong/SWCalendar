//
//  SWCalendarFactoryProtocol.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 3..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCalendarModelProtocol.h"

typedef enum {
    SWCalendarModelTypeDeco = 0,
    SWCalendarModelTypeFront,
    SWCalendarModelTypeMain,
    SWCalendarModelTypeRear
} SWCalendarModelType;

@protocol SWCalendarFactoryProtocol <NSObject>

@required

- (id<SWCalendarModelProtocol>)createCalendarModelWithDate:(NSDate *)date
                                                      type:(SWCalendarModelType)modelType;

@end
