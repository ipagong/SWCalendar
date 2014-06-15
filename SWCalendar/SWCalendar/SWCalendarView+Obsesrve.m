//
//  SWCalendarView+Obsesrve.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 15..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarView+Obsesrve.h"
#import "SWCalendarView+Paging.h"

#define kSWCalendarObserverKeyCurrentYear       @"currentYear"
#define kSWCalendarObserverKeyCurrentMonth      @"currentMonth"

#define kSWCalendarObserverKeyDirection         @"direction"

#define kSWCalendarObserverKeyContentSize       @"contentSize"

@implementation SWCalendarView (Obsesrve)

@dynamic isObserving;

#pragma mark - observing methods

- (void)registCalendarViewObserving
{
    if (self.isObserving == NO) {
        [self addObserver:self
               forKeyPath:kSWCalendarObserverKeyCurrentYear
                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                  context:nil];
        
        [self addObserver:self
               forKeyPath:kSWCalendarObserverKeyCurrentMonth
                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                  context:nil];
        
        [self addObserver:self
               forKeyPath:kSWCalendarObserverKeyDirection
                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                  context:nil];
        
        [self.collectionView addObserver:self
                              forKeyPath:kSWCalendarObserverKeyContentSize
                                 options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                 context:nil];
        
        self.isObserving = YES;
    }
}

- (void)removeCalendarViewObserving
{
    if (self.isObserving == YES) {
        
        [self removeObserver:self
                  forKeyPath:kSWCalendarObserverKeyCurrentYear];
        
        [self removeObserver:self
                  forKeyPath:kSWCalendarObserverKeyCurrentMonth];
        
        [self removeObserver:self
                  forKeyPath:kSWCalendarObserverKeyDirection];
        
        [self.collectionView removeObserver:self
                                 forKeyPath:kSWCalendarObserverKeyContentSize];
        
        self.isObserving = NO;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (change == nil || change.count == 0) {
        return;
    }
    
    if ([object isEqual:self] == YES) {
        [self changedCalendarViewValueForKeyPath:keyPath change:change context:context];
    }
    
    if ([object isEqual:self.collectionView] == YES) {
        [self changedCollectionViewValueForKeyPath:keyPath change:change context:context];
    }
}

- (void)changedCalendarViewValueForKeyPath:(NSString *)keyPath change:(NSDictionary *)change context:(void *)context
{
    NSInteger newValue = -1;
    NSInteger oldValue = -1;
    
    @try {
        newValue = [[change valueForKey:NSKeyValueChangeNewKey] integerValue];
        oldValue = [[change valueForKey:NSKeyValueChangeOldKey] integerValue];
    }
    @catch (NSException *exception) {
#ifdef DEBUG
        NSLog(@"[%s] %@", __PRETTY_FUNCTION__, exception);
#endif
    }
    
    if ([keyPath isEqualToString:kSWCalendarObserverKeyCurrentMonth] == YES) {
        [self obsesrverMonthWithNew:newValue old:oldValue];
    }
    
    if ([keyPath isEqualToString:kSWCalendarObserverKeyCurrentYear] == YES) {
        [self obsesrverYearWithNew:newValue old:oldValue];
    }
    
    if ([keyPath isEqualToString:kSWCalendarObserverKeyDirection] == YES) {
        [self obsesrverDirectionWithNew:newValue old:oldValue];
    }
}

- (void)changedCollectionViewValueForKeyPath:(NSString *)keyPath change:(NSDictionary *)change context:(void *)context
{
    NSValue *newSize = [change valueForKey:NSKeyValueChangeNewKey];
    NSValue *oldSize = [change valueForKey:NSKeyValueChangeOldKey];
    
    if (CGSizeEqualToSize(newSize.CGSizeValue, oldSize.CGSizeValue) == NO) {
        [self moveToCenterMonthWithScrollView:self.collectionView];
    }
}

- (void)obsesrverMonthWithNew:(NSInteger)new
                          old:(NSInteger)old
{
    [self reloadCalendar];
}

- (void)obsesrverYearWithNew:(NSInteger)new
                         old:(NSInteger)old
{
    [self reloadCalendar];
}

- (void)obsesrverDirectionWithNew:(NSInteger)new
                              old:(NSInteger)old
{
    [self reloadCalendar];
}


@end
