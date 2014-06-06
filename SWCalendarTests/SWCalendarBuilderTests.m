//
//  SWCalendarBuilderTests.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 6..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SWCalendarBuilder.h"
#import "SWCalendarSimpleFactory.h"
#import "NSDate+SWAddtions.h"

@interface SWCalendarBuilderTests : XCTestCase
@property (nonatomic, strong) SWCalendarBuilder *builder;
@property (nonatomic, strong) SWCalendarSimpleFactory *factory;
@end

@implementation SWCalendarBuilderTests

- (void)setUp
{
    [super setUp];
    
    self.factory = [[SWCalendarSimpleFactory alloc] init];
    
    self.builder = [[SWCalendarBuilder alloc] initWithModelFactory:self.factory];
}

- (void)tearDown
{
    self.builder = nil;
    self.factory = nil;
    
    [super tearDown];
}

- (void)testTotalModelCount
{
    NSDate *date = [NSDate date];
    
    date = [date sw_setDateWithYear:2014 month:4 day:10];
    
    [self.builder setDate:date];
    
    NSInteger totalModelCount = [self.builder totalModelCount];
    
    NSLog(@"[%s] count : %d", __PRETTY_FUNCTION__, totalModelCount);
    
}

@end
