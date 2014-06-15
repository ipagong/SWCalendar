//
//  SWCalendarSimpleDayModel.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 4..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCalendarModelProtocol.h"

@interface SWCalendarSimpleDayModel : NSObject <SWCalendarModelProtocol>

- (NSString *)cellKey;

@property (nonatomic, assign) NSInteger dayType;

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *subTitle;

@property (nonatomic, assign) BOOL isOtherMonth;

@end
