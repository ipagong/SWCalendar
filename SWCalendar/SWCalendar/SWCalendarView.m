//
//  SWCalendarView.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 30..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarView.h"
#import "SWCalendarView+Paging.h"
#import "SWCalendarView+Obsesrve.h"

#import "NSDate+SWAddtions.h"

#import "SWCalendarBuilder.h"
#import "SWCalendarModelProtocol.h"
#import "SWCalendarViewCellProtocol.h"

#import "SWCalendarSimpleFactory.h"


@interface SWCalendarView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, assign) NSInteger currentMonth;
@property (nonatomic, assign) CGRect collectionFrame;

@property (nonatomic, assign) BOOL isObserving;
@property (nonatomic, assign) NSInteger numberOfBuilder;

@property (nonatomic, strong) SWCalendarBuilder *builder;
@property (nonatomic, strong) id <SWCalendarFactoryProtocol> factory;

@property (nonatomic, strong) NSMutableDictionary *builders;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation SWCalendarView

- (id)initWithFrame:(CGRect)frame delegate:(id<SWCalendarViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.collectionFrame = frame;
        
        self.delegate = delegate;
        
        [self makeDefaultView];
        
        [self makeCalendar];
        
        [self registCalendarViewObserving];

    }
    return self;
}

- (void)dealloc
{
    [self removeCalendarViewObserving];
    
    self.collectionView = nil;
    self.date    = nil;
    
    self.builder = nil;
    self.factory = nil;
}

- (void)makeDefaultView
{
#pragma warning TODO : needs more flexible...for layout.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setAutoresizesSubviews:NO];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
    [self.collectionView setScrollsToTop:NO];
    
    [self addSubview:self.collectionView];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect collectionViewFrame = CGRectZero;
    
    if (CGRectIsEmpty(self.collectionFrame) == YES) {
        
        collectionViewFrame = CGRectMake(0, 0,
                                         CGRectGetWidth(self.bounds),
                                         CGRectGetHeight(self.bounds));
        
    } else {
        
        collectionViewFrame = CGRectMake(CGRectGetMinX(self.collectionFrame),
                                         CGRectGetMinY(self.collectionFrame),
                                         CGRectGetWidth(self.bounds),
                                         CGRectGetHeight(self.bounds));
    
        
    }
    
    switch (self.direction) {
            
        case SWCalendarViewScrollDirectionHorizontal:
            
            self.collectionView.alwaysBounceVertical    = NO;
            self.collectionView.alwaysBounceHorizontal  = YES;
            
            break;
            
        case SWCalendarViewScrollDirectionVertical:
            
            self.collectionView.alwaysBounceVertical    = YES;
            self.collectionView.alwaysBounceHorizontal  = NO;
            
            break;
            
        default:
            break;
    }
    
    
    [self.collectionView setFrame:collectionViewFrame];
    [self.collectionView reloadData];
    
    NSLog(@"%@ %@", NSStringFromCGRect(self.collectionView.frame), NSStringFromCGRect(self.collectionView.bounds));
}

//if need changed, override this methods.
#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    SWCalendarBuilder *builder = [self builderWithSection:section];
    
    CGFloat fitHeight = 50 * [builder numberOfCalendarVertical];
    CGFloat viewHeight = CGRectGetHeight(self.bounds);
    
    CGFloat footHeight = 0;
    
    if (fitHeight > viewHeight) {
        footHeight = viewHeight - (fitHeight - viewHeight);
    } else {
        footHeight = viewHeight - fitHeight;
    }
    
    return CGSizeMake(CGRectGetWidth(self.bounds), footHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWCalendarBuilder *builder = [self builderWithSection:indexPath.section];
    
    CGFloat cellWidth = CGRectGetWidth(self.bounds)/[builder numberOfCalendarHorizontal] - 0.5;
    
    return CGSizeMake(cellWidth, 50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - collectionViewDataSource methods

- (void)makeCalendar
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarModelFacotryWithCalendarView:)] == YES) {
        self.factory = [self.delegate calendarModelFacotryWithCalendarView:self];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarDefaultDateWithCalendarView:)] == YES) {
        self.date = [self.delegate calendarDefaultDateWithCalendarView:self];
    }
    
    if (self.factory == nil || [self.factory conformsToProtocol:@protocol(SWCalendarFactoryProtocol)] == NO) {
        self.factory = [[SWCalendarSimpleFactory alloc] init];
        
        self.date = [NSDate date];
    }
    
    self.currentYear  = [self.date sw_year];
    self.currentMonth = [self.date sw_month];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarView:changedCurrentDate:)] == YES) {
        [self.delegate calendarView:self changedCurrentDate:self.date];
    }
    
    self.builders = [NSMutableDictionary dictionaryWithCapacity:kSWCalendarBuilderDefaultCacheCount];

    [self loadCalendars];
    
    [self moveToCenterMonthWithScrollView:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.builders.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SWCalendarBuilder *builder = [self builderWithSection:section];
    
    return [builder totalModelCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWCalendarBuilder *builder = [self builderWithSection:indexPath.section];
    
    id <SWCalendarModelProtocol> model = [builder modelOfIndex:indexPath.row];
    
    [self.collectionView registerClass:[model cellClazz]
            forCellWithReuseIdentifier:[model cellKey]];
    
    UICollectionViewCell <SWCalendarViewCellProtocol> *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[model cellKey]
                                                                                                             forIndexPath:indexPath];
    
    [cell refreshCellWithModel:model];
    
    return cell;
}

- (SWCalendarBuilder *)builderWithSection:(NSInteger)section
{
    NSInteger monthGap = section - [self monthGap];
    
    NSDate *keyDate = [[NSDate date] sw_setDateWithYear:self.currentYear month:(self.currentMonth + monthGap) day:1];
    
    return [self.builders objectForKey:[keyDate sw_calendarKey]];
}

- (NSInteger)monthGap
{
    return (kSWCalendarBuilderDefaultCacheCount/2);
}

#pragma mark - calendar methods

- (void)reloadCalendar
{
    [self.builders removeAllObjects];
    
    [self loadCalendars];
    
    [self.collectionView reloadData];
}

- (void)loadCalendars
{
    NSDate *date = [[NSDate date] sw_setDateWithYear:self.currentYear month:(self.currentMonth - [self monthGap]) day:1];

    SWCalendarBuilder *builder = nil;
    
    for (int i = 0 ; i < kSWCalendarBuilderDefaultCacheCount ; i ++) {
    
        builder = [[SWCalendarBuilder alloc] initWithModelFactory:self.factory];
        [builder setDate:date];
        
        [self.builders setObject:builder forKey:[builder calendarKey]];
        
        date = [date sw_modifiedDateWithYear:0 month:1 day:0];
    }
    
}
@end
