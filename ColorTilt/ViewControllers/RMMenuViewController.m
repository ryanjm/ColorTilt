//
//  RMMenuViewController.m
//  ColorTilt
//
//  Created by Ryan Mathews on 2/7/14.
//  Copyright (c) 2014 Ryan Mathews. All rights reserved.
//

#import "RMMenuViewController.h"

#import "RMAutoLayoutViewController.h"

@interface RMMenuViewController ()

@end

@implementation RMMenuViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark - Actions

- (IBAction)autoLayoutButtonTapped:(id)sender {
    RMAutoLayoutViewController *vc = [[RMAutoLayoutViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)dynamicTableButtonTapped:(id)sender {
}

- (IBAction)colorsButtonTapped:(id)sender {
}
@end
