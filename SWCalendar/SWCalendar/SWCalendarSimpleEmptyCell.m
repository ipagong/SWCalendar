//
//  SWCalendarSimpleEmptyCell.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 7..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarSimpleEmptyCell.h"

@interface SWCalendarSimpleEmptyCell ()

@property (nonatomic, strong) UILabel *title;

@end

@implementation SWCalendarSimpleEmptyCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeDefaultView];
    }
    return self;
}

- (void)makeDefaultView
{
    self.title = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.title setNumberOfLines:1];
    [self.title setFont:[UIFont boldSystemFontOfSize:21]];
    [self.title setTextColor:[UIColor grayColor]];
    [self.title setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.title];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.title setFrame:CGRectMake(0, CGRectGetHeight(self.frame)/2 - 13,
                                    CGRectGetWidth(self.frame) , 26)];
    
}

- (void)refreshCellWithModel:(id<SWCalendarModelProtocol>)model
{
    if (model) {
        _model = model;
    }
    
    [self.title setText:[self.model title]];
}

@end
