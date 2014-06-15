//
//  SWCalendarSimpleDecoCell.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 7..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarSimpleDecoCell.h"

@interface SWCalendarSimpleDecoCell ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subTitle;

@end

@implementation SWCalendarSimpleDecoCell

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
    [self.title setFont:[UIFont boldSystemFontOfSize:18]];
    [self.title setTextColor:[UIColor whiteColor]];
    [self.title setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.title];
    
    self.subTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.subTitle setNumberOfLines:1];
    [self.subTitle setFont:[UIFont systemFontOfSize:7]];
    [self.subTitle setTextColor:[UIColor whiteColor]];
    [self.subTitle setTextAlignment:NSTextAlignmentCenter];
    [self.subTitle setLineBreakMode:NSLineBreakByWordWrapping];
    [self.subTitle setAdjustsFontSizeToFitWidth:YES];
    [self.contentView addSubview:self.subTitle];
    
    self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
    [self.backgroundView setBackgroundColor:[UIColor purpleColor]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.title setFrame:CGRectMake(0, CGRectGetHeight(self.frame)/2 - 13,
                                    CGRectGetWidth(self.frame) , 26)];
    
    [self.subTitle setFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 16,
                                       CGRectGetWidth(self.frame) , 14)];
}

- (void)refreshCellWithModel:(id<SWCalendarModelProtocol>)model
{
    if (model) {
        _model = model;
    }
    
    [self.title setText:[self.model title]];
    [self.subTitle setText:[self.model subTitle]];
}

@end
