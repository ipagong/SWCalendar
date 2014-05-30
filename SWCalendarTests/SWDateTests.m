//
//  SWDateTests.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 5. 29..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+SWAddtions.h"

@interface SWDateTests : XCTestCase

@property (nonatomic, strong) NSDate *date;

@end

@implementation SWDateTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (NSDate *)dateForTest
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setMonth:3];
    [components setDay:20];
    [components setYear:2014];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (void)testDay
{
    NSDate *date = [self dateForTest];
    
    XCTAssertEqual(20, [date sw_day], @"[2014/03/01] day value must be 1.");
}

- (void)testMonth
{
    NSDate *date = [self dateForTest];
    
    XCTAssertEqual(3, [date sw_month], @"[2014/03/01] day value must be 3.");
}

- (void)testYear
{
    NSDate *date = [self dateForTest];
    
    XCTAssertEqual(2014, [date sw_year], @"[2014/03/01] day value must be 2014.");
}

- (void)testWeakDay
{
    NSDate *date = [self dateForTest];
    
    XCTAssertEqual(5, [date sw_weakday], @"[2014/03/01] day value must be 5 weak.");
}

- (void)testWeakOfMonth
{
    NSDate *date = [self dateForTest];
    
    XCTAssertEqual(4, [date sw_weakOfMonth], @"[2014/03/01] day value must be 4 weak.");
}

- (void)testDateCount
{
    NSDate *date = [self dateForTest];
    
    NSLog(@"last date : %d", [date sw_dateCount]);
    
    XCTAssertTrue(31 == [date sw_dateCount], @"[2014/03/31] dateCount must be 31.");
}

@end
