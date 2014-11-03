//
//  NotamCell.m
//  SidebarDemo
//
//  Created by Uurtsaikh Batbileg on 1/6/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "NotamCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation NotamCell


@synthesize logo, title, description, scope, aitem, eitem;


static float space = 10.0f;
static float imageSize = 25.0f;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIView * background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width , 88 )];
        background.backgroundColor = [ UIColor whiteColor];
        
        //[background.layer setCornerRadius:3.0f];
        /*
        
        [background.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [background.layer setBorderWidth:0.15f];
        
        // drop shadow
        [background.layer setShadowColor:[UIColor blackColor].CGColor];
        [background.layer setShadowOpacity:0.15];
        [background.layer setShadowRadius:1.0];
        [background.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
        */
        
        [self addSubview:background];
        
        
        logo = [[UILabel alloc] initWithFrame:CGRectMake(space + 5, space, imageSize, 25)];
        logo.font = [UIFont fontWithName:@"HelveticaNeue" size:26];
        
        [self addSubview:logo];
        
        
        title = [[UILabel alloc] initWithFrame:CGRectMake((space*2) + imageSize, space, 130	, 25)];
        title.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:26];
        title.textColor = [FlightTool colorFromHexString:@"0884C2"];
        [self addSubview:title];
        
        
        aitem = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 120 , space, 110	, 13)];
        aitem.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        aitem.textColor = [FlightTool colorFromHexString:@"65CAFC"];
        aitem.textAlignment = NSTextAlignmentRight;
        [self addSubview:aitem];
        
        
        scope = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 120 , space + 13, 110	, 11)];
        scope.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:11];
        scope.textColor = [FlightTool colorFromHexString:@"805105"];
        scope.textAlignment = NSTextAlignmentRight;
        [self addSubview:scope];
        
        
        eitem = [[UILabel alloc] initWithFrame:CGRectMake(space * 2, space + 26,  self.frame.size.width - 30 , 50)];
        eitem.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
        eitem.numberOfLines = 5;
        eitem.textColor = [FlightTool colorFromHexString:@"939492"];
        [self addSubview:eitem];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
