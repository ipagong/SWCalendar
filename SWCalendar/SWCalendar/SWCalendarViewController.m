//
//  SWCalendarViewController.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 30..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarViewController.h"
#import "SWCalendarView.h"

@interface SWCalendarViewController ()

@property (nonatomic, strong) SWCalendarView *calendarView;

@end

@implementation SWCalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view = [self createBaseView];
        
        self.calendarView = [[SWCalendarView alloc] initWithFrame:self.view.frame];
        self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.calendarView.autoresizesSubviews = YES;
        
        [self.calendarView setDirection:SWCalendarViewScrollDirectionVertical];
        
        [self.view addSubview:self.calendarView];
        
        self.title = [NSString stringWithFormat:@"%@", [NSDate date]];
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

- (void)viewWillLayoutSubviews
{
    NSLog(@"1");
}

- (UIView *)createBaseView
{
    //Calculate Screensize
    BOOL statusBarHidden = [[UIApplication sharedApplication] isStatusBarHidden];
    
    BOOL navigationBarHidden = [self.navigationController isNavigationBarHidden];
    BOOL tabBarHidden = [self.tabBarController.tabBar isHidden];
    BOOL toolBarHidden = [self.navigationController isToolbarHidden];
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    //check if you should rotate the view, e.g. change width and height of the frame
    BOOL rotate = NO;
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        if (frame.size.width < frame.size.height) {
            rotate = YES;
        }
    }
    
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        if (frame.size.width > frame.size.height) {
            rotate = YES;
        }
    }
    
    if (rotate) {
        CGFloat tmp = frame.size.height;
        frame.size.height = frame.size.width;
        frame.size.width = tmp;
    }
    
    if (statusBarHidden) {
        frame.size.height -= [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    if (!navigationBarHidden) {
        frame.size.height -= self.navigationController.navigationBar.frame.size.height;
    }
    if (!tabBarHidden) {
        frame.size.height -= self.tabBarController.tabBar.frame.size.height;
    }
    if (!toolBarHidden) {
        frame.size.height -= self.navigationController.toolbar.frame.size.height;
    }
    
    UIView *v = [[UIView alloc] initWithFrame:frame];
    v.backgroundColor = [UIColor whiteColor];
    v.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    return v;
}


@end
