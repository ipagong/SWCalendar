//
//  SWCalendarViewCellProtocol.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 7..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCalendarConstants.h"
#import "SWCalendarModelProtocol.h"

@protocol SWCalendarViewCellProtocol <NSObject>

- (void)refreshCellWithModel:(id<SWCalendarModelProtocol>)model;

@property (nonatomic, strong, readonly) id <SWCalendarModelProtocol> model;

@end