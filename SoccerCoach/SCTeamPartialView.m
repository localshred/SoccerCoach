//
//  SCTeamBubbleView.m
//  SoccerCoach
//
//  Created by BJ on 8/10/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import "SCTeamPartialView.h"

@implementation SCTeamPartialView

@synthesize team;
@synthesize tapRecognizer;
@synthesize pressRecognizer;

- (id)initWithFrame:(CGRect)frame
            andTeam:(Team*)aTeam
{
  self = [super initWithFrame:frame];

  if (self) {
    team = aTeam;
    self.isNewTeamView = NO;
    self.backgroundColor = [UIColor clearColor];

    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(handleTapGesture:)];

    pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handleLongPressGesture:)];

    [self addGestureRecognizer:tapRecognizer];
    [self addGestureRecognizer:pressRecognizer];

    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ((self.frame.size.height / 2) - 10), self.frame.size.width, 20)];
    nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    nameLabel.textAlignment = UITextAlignmentCenter;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = team.name;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                     size:18];

    UILabel *seasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLabel.frame.origin.y + 25, self.frame.size.width, 20)];
    seasonLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    seasonLabel.textAlignment = UITextAlignmentCenter;
    seasonLabel.backgroundColor = [UIColor clearColor];
    seasonLabel.text = team.season;
    seasonLabel.textColor = [UIColor grayColor];
    seasonLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight"
                                       size:14];

    [self addSubview:nameLabel];
    [self addSubview:seasonLabel];
  }

  return self;
}

- (id)initAsNewTeamButtonWithFrame:(CGRect)frame
                withViewController:(UIViewController*)viewController
                   withTapSelector:(SEL)tapSelector
{
  self = [self initWithFrame:frame];

  if (self) {
    self.isNewTeamView = YES;

    team = [[Team alloc] init];
    team.name = @"+ add team";

    [self removeGestureRecognizer:self.tapRecognizer];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:viewController
                                                                 action:tapSelector];
    [self addGestureRecognizer:tapRecognizer];
  }

  return self;
}

- (void)drawRect:(CGRect)rect
{
  CGContextRef ctx = UIGraphicsGetCurrentContext();


  // Set stroke width and color.
  CGContextSetLineWidth(ctx, 3);

  if (self.isNewTeamView) {
    // adjust the Rect size/origin so the stroke isn't clipped.
    float oldWidth = rect.size.width;
    float oldHeight = rect.size.height;
    float newWidth = rect.size.width * 0.7;
    float newHeight = rect.size.height * 0.7;
    rect.size = CGSizeMake(newWidth, newHeight);
    rect.origin.x += (oldWidth - newWidth) / 2;
    rect.origin.y += (oldHeight - newHeight) / 2;

    // Setup an ellipse in rect.
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetStrokeColor(ctx, CGColorGetComponents([[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0] CGColor]));
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0] CGColor]));
  }
  else {
    // adjust the Rect size/origin so the stroke isn't clipped.
    rect.size = CGSizeMake(rect.size.width - 6, rect.size.height - 6);
    rect.origin.x += 3;
    rect.origin.y += 3;

    // Setup an ellipse in rect.
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetStrokeColor(ctx, CGColorGetComponents([[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.3] CGColor]));
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.1] CGColor]));
  }

  // Draw all the things.
  CGContextDrawPath(ctx, kCGPathFillStroke);
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tap
{
  NSLog(@"received a tap gesture on %@", team.name);
  self.teamTapped(self.team, tap);
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)tapRecognizer
{
  NSLog(@"received a long press gesture on %@", team.name);
}

@end