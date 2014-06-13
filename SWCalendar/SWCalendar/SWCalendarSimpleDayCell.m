//
//  SWCalendarSimpleDayCell.m
//  SWCalendar
//
//  Created by iPagongAir on 2014. 6. 7..
//  Copyright (c) 2014년 iPagong. All rights reserved.
//

#import "SWCalendarSimpleDayCell.h"

@interface SWCalendarSimpleDayCell ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation SWCalendarSimpleDayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeBackgroundView];
        [self makeDefaultView];
    }
    return self;
}

- (void)makeDefaultView
{
    self.title = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.title setNumberOfLines:1];
    [self.title setFont:[UIFont boldSystemFontOfSize:21]];
    [self.title setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.title];
}

- (void)makeBackgroundView
{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0.5, 0.5,
                                                            CGRectGetWidth(self.bounds) - 1,
                                                            CGRectGetHeight(self.bounds) - 1)];
    [self.bgView setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.contentView addSubview:self.bgView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.bgView setFrame:CGRectMake(0.5, 0.5,
                                    CGRectGetWidth(self.bounds) - 1,
                                    CGRectGetHeight(self.bounds) - 1)];
    
    [self.title setFrame:CGRectMake(0, CGRectGetHeight(self.frame)/2 - 13,
                                    CGRectGetWidth(self.frame) , 26)];
}

- (void)refreshCellWithModel:(id<SWCalendarModelProtocol>)model
{
    if (model) {
        _model = model;
    }

    [self changeTitleColor];
    
    [self.title setText:[self.model title]];
}

- (void)changeTitleColor
{
    switch ([self.model dayType]) {
        case SWCalendarDayTypeSunday:
        case SWCalendarDayTypeSaturday:
            [self.title setTextColor:[UIColor redColor]];
            break;
            
        default:
            [self.title setTextColor:[UIColor purpleColor]];
            break;
    }
}

@end
