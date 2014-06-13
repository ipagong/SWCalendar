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
        self.calendarView = [[SWCalendarView alloc] initWithFrame:CGRectMake(0, 30,
                                                                             CGRectGetWidth(self.view.frame),
                                                                             450)
                                                         delegate:self];
        
        self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.calendarView.autoresizesSubviews = YES;
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
    NSDate *date = [[NSDate date] sw_setDateWithYear:1952 month:10 day:1];
    
    return date;
}
@end
