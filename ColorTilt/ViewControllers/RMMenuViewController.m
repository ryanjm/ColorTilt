//
//  RMMenuViewController.m
//  ColorTilt
//
//  Created by Ryan Mathews on 2/7/14.
//  Copyright (c) 2014 Ryan Mathews. All rights reserved.
//

#import "RMMenuViewController.h"

#import "RMAutoLayoutViewController.h"
#import "RMAutoLayoutTableViewController.h"
#import "RMTextViewTableViewController.h"
#import "RMColorMathViewController.h"

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
    self.title = @"Menu";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    NSLog(@"shouldAutorotate --");
    return YES;
}

#pragma mark - Actions

- (IBAction)autoLayoutButtonTapped:(id)sender {
    RMAutoLayoutViewController *vc = [[RMAutoLayoutViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)dynamicTableButtonTapped:(id)sender {
    RMAutoLayoutTableViewController *vc = [[RMAutoLayoutTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)colorsButtonTapped:(id)sender {
    RMColorMathViewController *vc = [[RMColorMathViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)dynamicTextCellsButtonTapped:(id)sender {
    RMTextViewTableViewController *vc = [[RMTextViewTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
