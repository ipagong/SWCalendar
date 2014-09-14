//
//  SWCalendarSimpleFactory.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 3..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarSimpleFactory.h"

#import "SWCalendarDefaultDayModel.h"
#import "SWCalendarDefaultDecoModel.h"
#import "SWCalendarDefaultEmptyModel.h"

#import "SWCalendarModelProtocol.h"

@implementation SWCalendarSimpleFactory

#pragma mark - protocol methods

- (id<SWCalendarModelProtocol>)createCalendarModelWithDate:(NSDate *)date
                                                      type:(SWCalendarModelType)modelType
{
    id <SWCalendarModelProtocol> model = nil;
    
    switch (modelType) {
        case SWCalendarModelTypeDeco:
            model = [[SWCalendarDefaultDecoModel alloc] init];
            break;

        case SWCalendarModelTypeFront:
        case SWCalendarModelTypeRear:
            model = [[SWCalendarDefaultEmptyModel alloc] init];
            break;

        case SWCalendarModelTypeMain:
            model = [[SWCalendarDefaultDayModel alloc] init];
            break;

        default:
            break;
    }
    
    [model setType:modelType];
    
    return model;
}

@end
