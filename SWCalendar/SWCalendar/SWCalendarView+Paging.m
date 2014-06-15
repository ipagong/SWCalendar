//
//  SWCalendarView+Paging.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 13..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarView+Paging.h"
#import "NSDate+SWAddtions.h"

typedef struct {
    
    CGFloat contentOffsetSize;
    CGFloat pageSize;
    CGFloat contentSize;
    
    NSInteger pageCount;
    
} SWCalendarSize;

@interface SWCalendarView () <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, assign) NSInteger currentMonth;

@end

@implementation SWCalendarView (Paging)

#pragma mark - scrollView delegate methods
static NSInteger previousPage = 0;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger changedPage = [self changedPageWithScrollView:scrollView];
    
    if (changedPage == previousPage) return;
    
    NSInteger offsetMonth = changedPage - previousPage;
    
    self.date = [NSDate sw_dateWithYear:self.currentYear
                                  month:self.currentMonth - offsetMonth
                                    day:1];
        
    previousPage = changedPage;
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    scrollView.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    scrollView.userInteractionEnabled = YES;

    if (self.currentYear == [self.date sw_year] && self.currentMonth == [self.date sw_month]) {
        return;
    }
    
    [self moveToCenterMonthWithScrollView:scrollView];
    
    self.currentYear  = [self.date sw_year];
    self.currentMonth = [self.date sw_month];

    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarView:changedCurrentDate:)] == YES) {
        [self.delegate calendarView:self changedCurrentDate:self.date];
    }
    
    [self reloadCalendar]; // TODO : changed model that will be not used.
}

#pragma mark - paging calculation methods

- (void)moveToCenterMonthWithScrollView:(UIScrollView *)scrollView
{
    if (CGRectIsEmpty(scrollView.frame) == YES) return;
    
    CGFloat realPage = scrollView.contentSize.height/CGRectGetHeight(scrollView.bounds);
    
    NSInteger centerCount = realPage/2;
    CGFloat contentOffset = CGRectGetHeight(scrollView.bounds) * centerCount;
    
    [scrollView setContentOffset:CGPointMake(0, contentOffset)];
}


- (SWCalendarSize)calendarSizeWithScrollView:(UIScrollView *)scrollView
{
    SWCalendarSize calendarSize;
    
    switch (self.direction) {
        case SWCalendarViewScrollDirectionHorizontal:
        {
            calendarSize.pageSize = CGRectGetWidth(scrollView.bounds);
            calendarSize.contentOffsetSize = scrollView.contentOffset.x;
            calendarSize.contentSize = scrollView.contentSize.width;
        }
            break;
            
        case SWCalendarViewScrollDirectionVertical:
        {
            calendarSize.pageSize = CGRectGetHeight(scrollView.bounds);
            calendarSize.contentOffsetSize = scrollView.contentOffset.y;
            calendarSize.contentSize = scrollView.contentSize.height;
        }
            break;
            
        default:
            break;
    }
    
    calendarSize.pageCount = calendarSize.contentSize/calendarSize.pageSize;
    
    return calendarSize;
}

- (NSInteger)changedPageWithScrollView:(UIScrollView *)scrollView
{
    SWCalendarSize calendarSize = [self calendarSizeWithScrollView:scrollView];
    
    CGFloat fractionalPage = calendarSize.contentOffsetSize / calendarSize.pageSize;

    NSInteger page = lround(fractionalPage);
    
    return page;
}

@end
