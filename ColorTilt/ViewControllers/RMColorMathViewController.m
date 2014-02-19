//
//  RMColorMathViewController.m
//  ColorTilt
//
//  Created by Ryan Mathews on 2/16/14.
//  Copyright (c) 2014 Ryan Mathews. All rights reserved.
//

#import "RMColorMathViewController.h"
#import "KeyValueObserver.h"
#import <CoreMotion/CoreMotion.h>

@interface RMColorMathViewController ()
@property (weak, nonatomic) IBOutlet UIButton *colorOneButton;
@property (weak, nonatomic) IBOutlet UIButton *colorTwoButton;
@property (weak, nonatomic) IBOutlet UIView *colorThreeView;

@property (weak, nonatomic) IBOutlet UILabel *colorOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorThreeLabel;

@property (nonatomic, strong) UIColor *colorOne;
@property (nonatomic, strong) UIColor *colorTwo;
@property (nonatomic, strong) UIColor *currentColor;

@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic, strong) id colorOneObserveToken;
@property (nonatomic, strong) id colorTwoObserveToken;

- (void)colorChangedOne:(id)sender;
- (void)colorChangedTwo:(id)sender;

- (IBAction)colorOneTapped:(id)sender;
- (IBAction)colorTwoTapped:(id)sender;
@end

@implementation RMColorMathViewController
@synthesize currentColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.colorOneObserveToken = [KeyValueObserver observeObject:self keyPath:@"colorOne" target:self selector:@selector(colorChangedOne:) options:NSKeyValueObservingOptionInitial];
    self.colorTwoObserveToken = [KeyValueObserver observeObject:self keyPath:@"colorTwo" target:self selector:@selector(colorChangedTwo:) options:NSKeyValueObservingOptionInitial];
    
    self.colorOne = [UIColor redColor];
    self.colorTwo = [UIColor blueColor];
    
    [self startMotionManager];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    NSLog(@"should autorotate?");
    return currentColor == nil;
}

- (NSUInteger)supportedInterfaceOrientations
{
    NSLog(@"asking for supportedInterfaces");
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

#pragma mark - CMMotionManager

- (void)startMotionManager
{
    self.motionManager = [[CMMotionManager alloc] init];
    
    //Gyroscope
    if([self.motionManager isGyroAvailable])
    {
        /* Start the gyroscope if it is not active already */
        if([self.motionManager isGyroActive] == NO)
        {
            [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
                if (self.currentColor){
                    double roll = motion.attitude.roll; // +/- 1
                    double pitch = motion.attitude.pitch; // +/- 0.7
                    double yaw = motion.attitude.yaw; // +/- 0.08
//                    NSLog(@"%.4f, %.4f, %.4f", roll, pitch, yaw);
                    [self updateColorWithRoll:roll pitch:pitch andYaw:yaw];
                }
            }];
        }
    }
    else
    {
        NSLog(@"Gyroscope not Available!");
    }
}

#pragma mark - Helper Methods

- (NSArray*)colorToCMYK:(UIColor*)color
{
    CGFloat red = 0.0; CGFloat green = 0.0; CGFloat blue = 0.0; CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    CGFloat k = MIN(255-red,MIN(255-green,255-blue));
    CGFloat c = 255*(255-red-k)/(255-k);
    CGFloat m = 255*(255-green-k)/(255-k);
    CGFloat y = 255*(255-blue-k)/(255-k);
    
    return @[@(k), @(c), @(m), @(y)];
}

- (void)updateColorThree
{
//    NSArray *cmyk1 = [self colorToCMYK:self.colorOne];
//    NSArray *cmyk2 = [self colorToCMYK:self.colorTwo];
//
//    CGFloat k = [cmyk1[0] floatValue] + [cmyk2[0] floatValue];
//    CGFloat c = [cmyk1[1] floatValue] + [cmyk2[1] floatValue];
//    CGFloat m = [cmyk1[2] floatValue] + [cmyk2[2] floatValue];
//    CGFloat y = [cmyk1[3] floatValue] + [cmyk2[3] floatValue];
//    
//    CGFloat colors[5] = { c, m, y, k, 1.0 };
//    NSLog(@"%.4f, %.4f, %.4f, %.4f", k, c, m, y);
    
    // add color one and two together
    CGFloat red1 = 0.0; CGFloat green1 = 0.0; CGFloat blue1 = 0.0; CGFloat alpha1 = 0.0;
    [self.colorOne getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    
    CGFloat red2 = 0.0; CGFloat green2 = 0.0; CGFloat blue2 = 0.0; CGFloat alpha2 = 0.0;
    [self.colorTwo getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
    
//    CGColorSpaceRef cmykColorSpace = CGColorSpaceCreateDeviceCMYK();
////    CGFloat colors[5] = {1, 1, 1, 1, 1}; // CMYK+Alpha
//    CGColorRef cgColor = CGColorCreate(cmykColorSpace, colors);
//    UIColor *colorThree = [UIColor colorWithCGColor:cgColor];
//    CGColorRelease(cgColor);
//    CGColorSpaceRelease(cmykColorSpace);
    
    CGFloat red = (red1/2) + (red2/2);
    CGFloat green = (green1/2) + (green2/2);
    CGFloat blue = (blue1/2) + (blue2/2);
    
    UIColor *colorThree = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];

//    CGFloat red = 0.0; CGFloat green = 0.0; CGFloat blue = 0.0; CGFloat alpha = 0.0;
//    [colorThree getRed:&red green:&green blue:&blue alpha:&alpha];
    
    // set to colorThreeView
    self.colorThreeView.backgroundColor = colorThree;
    self.colorThreeLabel.text = [NSString stringWithFormat:@"Color 3: rgb(%.2f,%.2f,%.2f)", red, green, blue];
}

- (CGFloat)minMax:(CGFloat)num max:(CGFloat)maxNumber
{
    return MAX(MIN(num, 0.0), maxNumber);
}

- (CGFloat)translateAttitudeNumber:(CGFloat)num byOffset:(CGFloat)offset
{
    num = num + offset; // add the offset (should get it to be positive)
    num = MAX(num, 0); // make sure it is at least 0
    num = MIN(num, offset * 2); // make sure it is less than twice the offset
    num = num / (offset * 2); // translate it to be between 0 and 1
    return num;
}

- (void)updateColorWithRoll:(CGFloat)roll pitch:(CGFloat)pitch andYaw:(CGFloat)yaw
{
    CGFloat rollOffset = 1.0;
    CGFloat pitchOffset = 0.7;
    CGFloat yawOffset = 1.0;
    
    // normalize each number to be positive and
    // then multiply by the a number so if falls within 0 and 1
    CGFloat red = [self translateAttitudeNumber:roll byOffset:rollOffset];
    CGFloat green = [self translateAttitudeNumber:pitch byOffset:pitchOffset];
    CGFloat blue = [self translateAttitudeNumber:yaw byOffset:yawOffset];
//    NSLog(@"%.4f, %.4f, %.4f", red, green, blue);
    
    // Create a new color
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // figure out which color is the current one and set it
    if (currentColor == self.colorOne) {
        self.colorOne = newColor;
    }
    else if (currentColor == self.colorTwo) {
        self.colorTwo = newColor;
    }
    self.currentColor = newColor;
}

#pragma mark - KVO Observations

- (void)colorChangedOne:(id)sender
{
    self.colorOneButton.backgroundColor = self.colorOne;
    
    CGFloat red = 0.0; CGFloat green = 0.0; CGFloat blue = 0.0; CGFloat alpha = 0.0;
    [self.colorOne getRed:&red green:&green blue:&blue alpha:&alpha];
    self.colorOneLabel.text = [NSString stringWithFormat:@"Color 1: rgb(%.2f,%.2f,%.2f)", red, green, blue];
    
    [self updateColorThree];
}

- (void)colorChangedTwo:(id)sender
{
    self.colorTwoButton.backgroundColor = self.colorTwo;
    
    CGFloat red = 0.0; CGFloat green = 0.0; CGFloat blue = 0.0; CGFloat alpha = 0.0;
    [self.colorTwo getRed:&red green:&green blue:&blue alpha:&alpha];
    self.colorTwoLabel.text = [NSString stringWithFormat:@"Color 2: rgb(%.2f,%.2f,%.2f)", red, green, blue];
    
    [self updateColorThree];
}

#pragma mark - Button Actions

- (IBAction)colorOneTapped:(id)sender
{
    if (self.currentColor == self.colorOne)
        self.currentColor = nil;
    else
        self.currentColor = self.colorOne;
}

- (IBAction)colorTwoTapped:(id)sender
{
    if (self.currentColor == self.colorTwo)
        self.currentColor = nil;
    else
        self.currentColor = self.colorTwo;
}
@end
