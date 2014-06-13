//
//  SWCalendarView.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 30..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarView.h"

#import "NSDate+SWAddtions.h"

#import "SWCalendarBuilder.h"
#import "SWCalendarModelProtocol.h"
#import "SWCalendarViewCellProtocol.h"

#import "SWCalendarSimpleFactory.h"


#define kSWCalendarObserverKeyCurrentYear       @"currentYear"
#define kSWCalendarObserverKeyCurrentMonth      @"currentMonth"

#define kSWCalendarObserverKeyDirection         @"direction"

@interface SWCalendarView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, assign) NSInteger currentMonth;

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
    self.defaultDate    = nil;
    
    self.builder = nil;
    self.factory = nil;
}

- (void)makeDefaultView
{
#pragma warning TODO : needs more flexible...for layout.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [self.collectionView setPagingEnabled:YES];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self addSubview:self.collectionView];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect collectionViewFrame = CGRectZero;
    
    if (CGRectIsEmpty(self.collectionFrame) == YES) {
        
        collectionViewFrame = CGRectMake(0, 0,
                                         CGRectGetWidth(self.frame),
                                         CGRectGetHeight(self.frame));
        
    } else {
        
        collectionViewFrame = self.collectionFrame;
        
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
}

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

- (void)obsesrverDirectionWithNew:(SWCalendarViewScrollDirection)new
                              old:(SWCalendarViewScrollDirection)old
{
    
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
    
    return CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - fitHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWCalendarBuilder *builder = [self builderWithSection:indexPath.section];
    
    CGFloat cellWidth = CGRectGetWidth(self.bounds)/[builder numberOfCalendarHorizontal];
    
    return CGSizeMake(cellWidth, 50);
}

#pragma mark - collectionViewDataSource methods

- (void)makeCalendar
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarModelFacotryWithCalendarView:)] == YES) {
        self.factory = [self.delegate calendarModelFacotryWithCalendarView:self];
    }
    
    NSDate *defaultDate = nil;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarDefaultDateWithCalendarView:)] == YES) {
        defaultDate = [self.delegate calendarDefaultDateWithCalendarView:self];
    }
    
    if (self.factory == nil || [self.factory conformsToProtocol:@protocol(SWCalendarFactoryProtocol)] == NO) {
        self.factory = [[SWCalendarSimpleFactory alloc] init];
        
        defaultDate = [NSDate date];
    }
    
    self.currentYear  = [defaultDate sw_year];
    self.currentMonth = [defaultDate sw_month];
    
    self.builders = [NSMutableDictionary dictionaryWithCapacity:kSWCalendarBuilderDefaultCacheCount];

    [self loadCalendars];
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

- (UIPageControl *)pageControl
{
    return nil;
}

@end
