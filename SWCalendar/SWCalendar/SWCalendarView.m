//
//  SWCalendarView.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 30..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarView.h"

#define kSWCalendarObserverKeyCurrentYear       @"currentYear"
#define kSWCalendarObserverKeyCurrentMonth      @"currentMonth"

#define kSWCalendarObserverKeyDirection         @"direction"

@interface SWCalendarView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, assign) NSInteger currentMonth;

@property (nonatomic, assign) BOOL isObserving;

@end

@implementation SWCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self makeDefaultView];

        [self registCalendarViewObserving];
    }
    return self;
}

- (void)dealloc
{
    [self removeCalendarViewObserving];
    
    self.collectionView = nil;
    self.defaultDate    = nil;
}

- (void)makeDefaultView
{
#pragma warning TODO : needs more flexible...for layout.
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
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
    
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
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
    
    [self.collectionView setFrame:collectionViewFrame];
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

#pragma mark - collectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - calendar methods

- (void)reloadCalendar
{
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}

@end
