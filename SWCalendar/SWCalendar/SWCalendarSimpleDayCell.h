//
//  SWCalendarSimpleDayCell.h
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 7..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWCalendarViewCellProtocol.h"

@interface SWCalendarSimpleDayCell : UICollectionViewCell <SWCalendarViewCellProtocol>

@property (nonatomic, strong, readonly) id <SWCalendarModelProtocol> model;

@end
