//
//  SWCalendarViewController.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 30..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarViewController.h"
#import "SWCalendarView.h"
#import "SWCalendarSimpleFactory.h"



#import "NSDate+SWAddtions.h"

@interface SWCalendarViewController () <SWCalendarViewDelegate>

@property (nonatomic, strong) SWCalendarView *calendarView;

@end

@implementation SWCalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = NO;
        
        self.calendarView = [[SWCalendarView alloc] initWithFrame:CGRectMake(0, 0,
                                                                             CGRectGetWidth(self.view.bounds),
                                                                             CGRectGetHeight(self.view.bounds))
                                                         delegate:self];
        
        self.calendarView.delegate = self;
        [self.calendarView setDirection:SWCalendarViewScrollDirectionVertical];
        
        [self.view addSubview:self.calendarView];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - SWCalendarViewDelegate methods

- (id<SWCalendarFactoryProtocol>)calendarModelFacotryWithCalendarView:(SWCalendarView *)calendarView
{
    return [[SWCalendarSimpleFactory alloc] init];
}


- (NSDate *)calendarDefaultDateWithCalendarView:(SWCalendarView *)calendarView
{
    return [NSDate date];
}

- (void)calendarView:(SWCalendarView *)calendarView changedCurrentDate:(NSDate *)date
{
    self.title = [NSString stringWithFormat:@"%ld.%02ld", [date sw_year], [date sw_month]];
}
@end
