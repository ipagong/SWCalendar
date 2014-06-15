//
//  SWCalendarView.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 30..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWCalendarConstants.h"
#import "SWCalendarFactoryProtocol.h"

@class SWCalendarView;

@protocol SWCalendarViewDelegate <NSObject>

- (id <SWCalendarFactoryProtocol>)calendarModelFacotryWithCalendarView:(SWCalendarView *)calendarView;
- (NSDate *)calendarDefaultDateWithCalendarView:(SWCalendarView *)calendarView;
- (void)calendarView:(SWCalendarView *)calendarView changedCurrentDate:(NSDate *)date;

@end

@interface SWCalendarView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, assign) SWCalendarViewScrollDirection direction;

@property (nonatomic, weak) id <SWCalendarViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id<SWCalendarViewDelegate>)delegate;

- (void)reloadCalendar;

@end
