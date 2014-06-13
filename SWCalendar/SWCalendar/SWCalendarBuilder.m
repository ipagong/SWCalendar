//
//  SWCalendarBuilder.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 2..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarBuilder.h"
#import "NSDate+SWAddtions.h"
#import "SWCalendarModelProtocol.h"
#import "SWCalendarConstants.h"

#define kSWCalendarDecorationCapacity 7

@interface SWCalendarBuilder ()

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSMutableArray *decoModels;
@property (nonatomic, strong) NSMutableArray *frontModels;
@property (nonatomic, strong) NSMutableArray *mainModels;
@property (nonatomic, strong) NSMutableArray *rearModels;

@property (nonatomic, strong) NSMutableArray *totalModels;

@property (nonatomic, strong) id<SWCalendarFactoryProtocol> factory;

@end

@implementation SWCalendarBuilder

- (instancetype)initWithModelFactory:(id<SWCalendarFactoryProtocol>)factory
{
    self = [super init];
    if (self) {
        
        self.factory = factory;
        
        self.decoModels  = [NSMutableArray array];
        self.frontModels = [NSMutableArray array];
        self.mainModels  = [NSMutableArray array];
        self.rearModels  = [NSMutableArray array];
        
        self.totalModels = [NSMutableArray array];
        
        [self setDefaultDate];
    }
    return self;
}

- (void)dealloc
{
    [self removeAllModels];
    
    self.decoModels  = nil;
    self.frontModels = nil;
    self.mainModels  = nil;
    self.rearModels  = nil;
    self.totalModels = nil;
    self.date = nil;
    
    self.factory = nil;
}

#pragma mark - sw calendar methods

- (void)setDefaultDate
{
    NSDate *date = [NSDate date];
    
    [self setDate:date];
}

- (void)setDate:(NSDate *)date
{
    if (date && [_date isEqualToDate:date] == NO) {
        
        _date = date;
        
        self.year = [date sw_year];
        self.month = [date sw_month];
        
        [self reloadModels];
    }
}


- (void)reloadModels
{
    if (self.factory == nil) {
#ifdef DEBUG
        NSLog(@"[%s] calendarFactory should not be nil.", __PRETTY_FUNCTION__);
#endif
        return;
    }
    
    if ([self.factory respondsToSelector:@selector(createCalendarModelWithDate:type:)] == NO) {
#ifdef DEBUG
        NSLog(@"[%s] calendarFactory was not injectioned.", __PRETTY_FUNCTION__);
#endif
        return;
    }

    [self removeAllModels];
    
    [self setupDecorationModels];
    [self setupFrontModels];
    [self setupMainModels];
    [self setupRearModels];
    
    [self addTotalModelsWithModels:self.decoModels];
    [self addTotalModelsWithModels:self.frontModels];
    [self addTotalModelsWithModels:self.mainModels];
    [self addTotalModelsWithModels:self.rearModels];

}

- (void)addTotalModelsWithModels:(NSMutableArray *)array
{
    if (array && array.count) {
        [self.totalModels addObjectsFromArray:array];
    }
}

- (void)removeAllModels
{
    [self.decoModels  removeAllObjects];
    [self.frontModels removeAllObjects];
    [self.mainModels  removeAllObjects];
    [self.rearModels  removeAllObjects];
    
    [self.totalModels removeAllObjects];
}

- (void)setupDecorationModels
{
    for (int day = 1 ; day <= kSWCalendarDecorationCapacity ; day ++) {
        
        id<SWCalendarModelProtocol> model = [self.factory createCalendarModelWithDate:nil
                                                                                 type:SWCalendarModelTypeDeco];
        
        [model setDayType:day];
        
        if (model) {
            [self.decoModels addObject:model];
        }
        
    }
}

- (void)setupFrontModels
{
    NSDate *date = [self.date sw_setDateWithYear:self.year month:self.month day:0];
    
    while ([date sw_weakday] != SWCalendarDayTypeSaturday) {
        
        id<SWCalendarModelProtocol> model = [self.factory createCalendarModelWithDate:date
                                                                                 type:SWCalendarModelTypeFront];
        
        [model setYear:[date sw_year]];
        [model setMonth:[date sw_month]];
        [model setDay:[date sw_day]];
        
        [model setDayType:[date sw_weakday]];
        
        if (model) {
            
            [self.frontModels insertObject:model atIndex:0];
            
        }
        
        date = [date sw_modifiedDateWithYear:0 month:0 day:-1];
    }
}

- (void)setupMainModels
{
    NSInteger lastDay = [self lastDay];
    
    for (int currentDay = lastDay; currentDay > 0; currentDay--) {
        
        NSDate *date = [self.date sw_setDateWithYear:self.year
                                               month:self.month
                                                 day:currentDay];
        
        id<SWCalendarModelProtocol> model = [self.factory createCalendarModelWithDate:date
                                                                                 type:SWCalendarModelTypeMain];
        
        [model setYear:[date sw_year]];
        [model setMonth:[date sw_month]];
        [model setDay:[date sw_day]];
        
        [model setDayType:[date sw_weakday]];
        
        if (model) {
            [self.mainModels insertObject:model atIndex:0];
        }
    }
}

- (void)setupRearModels
{
    NSDate *date = [self.date sw_setDateWithYear:self.year month:(self.month + 1) day:1];
    
    while ([date sw_weakday] != SWCalendarDayTypeSunday) {
        
        id<SWCalendarModelProtocol> model = [self.factory createCalendarModelWithDate:date
                                                                                 type:SWCalendarModelTypeRear];
        
        [model setYear:[date sw_year]];
        [model setMonth:[date sw_month]];
        [model setDay:[date sw_day]];
        
        [model setDayType:[date sw_weakday]];
        
        if (model) {
            
            [self.rearModels addObject:model];
            
        }
        
        date = [date sw_modifiedDateWithYear:0 month:0 day:1];
    }
}

#pragma mark - public methods

- (NSString *)calendarKey
{
    if (self.date) {
        return [self.date sw_calendarKey];
    }
    return kSWCalendarBuilderDefaultKey;
}

- (id<SWCalendarModelProtocol>)modelOfIndex:(NSInteger)index
{
    if (self.totalModels && index < self.totalModels.count) {
        return [self.totalModels objectAtIndex:index];
    }
    return nil;
}

- (NSInteger)totalModelCount
{
    return self.decoModels.count + self.frontModels.count + self.mainModels.count + self.rearModels.count;
}

- (NSInteger)numberOfCalendarVertical
{
    return [self totalModelCount] / SWCalendarDayTypeSaturday;
}

- (NSInteger)numberOfCalendarHorizontal
{
    return SWCalendarDayTypeSaturday;
}

- (NSInteger)lastDay
{
    return [self.date sw_dateCount];
}

@end
