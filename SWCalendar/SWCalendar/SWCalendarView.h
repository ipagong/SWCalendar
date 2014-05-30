//
//  SWCalendarView.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 30..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWCalendarConstants.h"

@interface SWCalendarView : UIView

@property (nonatomic, assign) CGRect collectionFrame;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSDate *defaultDate;

@property (nonatomic, assign) SWCalendarViewScrollDirection direction;

@end
