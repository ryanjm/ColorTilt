//
//  RMTextViewTableViewController.m
//  ColorTilt
//
//  Created by Ryan Mathews on 2/13/14.
//  Copyright (c) 2014 Ryan Mathews. All rights reserved.
//

#import "RMTextViewTableViewController.h"
#import "RMTextViewCell.h"

@interface RMTextViewTableViewController ()

@property (nonatomic, strong) NSMutableArray *textStrings;
@property (nonatomic, strong) NSMutableArray *rowHeights;
@property (nonatomic, strong) NSNumber *selectedRow;
@end

@implementation RMTextViewTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textStrings = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        [self.textStrings addObject:[NSString stringWithFormat:@"%i", i]];
    }
    self.rowHeights = [NSMutableArray array];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UINib *dynamicCell = [UINib nibWithNibName:@"RMTextViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:dynamicCell forCellReuseIdentifier:@"RMTextViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RMTextViewCell";
    RMTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textView.delegate = self;
    [self configureCell:cell forIndexPath:indexPath];
    [cell.textView needsUpdateConstraints];
//    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1){
//        cell.textView.textContainer.heightTracksTextView = YES;
//    }
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (void)configureCell:(RMTextViewCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    cell.textView.tag = indexPath.row;
    cell.textView.text = [self.textStrings objectAtIndex:indexPath.row];
    
    cell.textView.scrollEnabled = NO;
    
    cell.titleLabel.text = @"This is a longer title";
    cell.subtextLabel.text = @"And a longer subtext";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // use cached height if there is one (and it isn't the selected row)
    if ([self.selectedRow integerValue] != indexPath.row && indexPath.row < [self.rowHeights count]){
        return [[self.rowHeights objectAtIndex:indexPath.row] floatValue];
    }
    
    static NSString *CellIdentifier = @"RMTextViewCell";
    RMTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell forIndexPath:indexPath];
    
    [cell layoutIfNeeded];

    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    height += 1; // add 1 for border
    
    NSLog(@"height(%f)", height);
    
    NSNumber *h = @(height);
    [self.rowHeights setObject:h atIndexedSubscript:indexPath.row];
    
    return height;
}


#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.selectedRow = @(textView.tag);
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.selectedRow = nil;
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"row: %i", textView.tag);
    [self.textStrings setObject:textView.text atIndexedSubscript:textView.tag];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

@end
