//
//  RMColorTilt.m
//  ColorTilt
//
//  Created by Ryan Mathews on 1/20/14.
//  Copyright (c) 2014 Ryan Mathews. All rights reserved.
//

#import "RMColorTilt.h"
#import <CoreMotion/CoreMotion.h>

@interface RMColorTilt ()

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation RMColorTilt
@synthesize motionManager;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self handleTilts];
    }
    return self;
}

- (void)handleTilts
{
    self.motionManager = [[CMMotionManager alloc] init];
    
    
    //Gyroscope
    if([self.motionManager isGyroAvailable])
    {
        /* Start the gyroscope if it is not active already */
        if([self.motionManager isGyroActive] == NO)
        {
            /* Update us x times a second */
            [self.motionManager setGyroUpdateInterval:1.0f / 4.0f];
            
            /* Add on a handler block object */
            
            /* Receive the gyroscope data on this block */
            [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
                                            withHandler:^(CMGyroData *gyroData, NSError *error)
             {
                 double x = gyroData.rotationRate.x;
                 double y = gyroData.rotationRate.y;
                 double z = gyroData.rotationRate.z;

//                 NSLog(@"(%0.02f, %0.02f, %0.02f)", x, y, z);
                 
                 UIColor *color = [UIColor colorWithRed:fabs(x) green:fabs(y) blue:fabs(z) alpha:1];
                 [self setBackgroundColor:color];
             }];
        }
    }
    else
    {
        NSLog(@"Gyroscope not Available!");
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//}

- (BOOL)canBecomeFirstResponder
{
    return TRUE;
}

@end
