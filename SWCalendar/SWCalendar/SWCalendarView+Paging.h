//
//  SWCalendarView+Paging.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 13..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarView.h"

@interface SWCalendarView (Paging) <UIScrollViewDelegate>

- (void)moveToCenterMonthWithScrollView:(UIScrollView *)scrollView;

@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, assign) NSInteger currentMonth;

@end
