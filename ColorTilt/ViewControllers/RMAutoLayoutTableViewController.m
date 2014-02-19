//
//  RMAutoLayoutTableViewController.m
//  ColorTilt
//
//  Created by Ryan Mathews on 2/12/14.
//  Copyright (c) 2014 Ryan Mathews. All rights reserved.
//

#import "RMAutoLayoutTableViewController.h"
#import "RMDynamicItemCell.h"

@interface RMAutoLayoutTableViewController ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *descriptions;

@end

@implementation RMAutoLayoutTableViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UINib *dynamicCell = [UINib nibWithNibName:@"RMDynamicItemCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:dynamicCell forCellReuseIdentifier:@"RMDynamicItemCell"];
    
    self.titles = @[@"This is a short title", @"This is a really long title that should go to multiple lines.", @"This is a short title", @"This is a really long title that should go to multiple lines.", @"This is a short title", @"This is a really long title that should go to multiple lines.", @"This is a short title", @"This is a really long title that should go to multiple lines."];
    self.descriptions = @[@"Description 1", @"Description 2 is much longer and should go to multiple lines. Description 2 is much longer and should go to multiple lines. Description 2 is much longer and should go to multiple lines. Description 2 is much longer and should go to multiple lines. Description 2 is much longer and should go to multiple lines.", @"Description 3 is longer and should go to multiple lines. Description 3 is longer and should go to multiple lines.",@"Description 1", @"Description 2 is much longer and should go to multiple lines. Description 2 is much longer and should go to multiple lines. Description 2 is much longer and should go to multiple lines. Description 2 is much longer and should go to multiple lines. Description 2 is much longer and should go to multiple lines.", @"Description 3 is longer and should go to multiple lines. Description 3 is longer and should go to multiple lines."];
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
    return MIN(self.titles.count, self.descriptions.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RMDynamicItemCell";
    RMDynamicItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell forIndexPath:indexPath];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    NSLog(@"%@ cell: %i contentView: %i", indexPath, [cell translatesAutoresizingMaskIntoConstraints], [cell.contentView translatesAutoresizingMaskIntoConstraints]);
    return cell;
}

- (void)configureCell:(RMDynamicItemCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    cell.titleLabel.text = self.titles[indexPath.row];
    cell.descriptionLabel.text = self.descriptions[indexPath.row];
    [cell.button setTitle:@"Push Me!!" forState:UIControlStateNormal];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMDynamicItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RMDynamicItemCell"];
    
    // Configure the cell for this indexPath
    [self configureCell:cell forIndexPath:indexPath];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // The cell's width must be set to the same size it will end up at once it is in the table view.
    // This is important so that we'll get the correct height for different table view widths, since our cell's
    // height depends on its width due to the multi-line UILabel word wrapping. Don't need to do this above in
    // -[tableView:cellForRowAtIndexPath:] because it happens automatically when the cell is used in the table view.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    // NOTE: if you are displaying a section index (e.g. alphabet along the right side of the table view), or
    // if you are using a grouped table view style where cells have insets to the edges of the table view,
    // you'll need to adjust the cell.bounds.size.width to be smaller than the full width of the table view we just
    // set it to above. See http://stackoverflow.com/questions/3647242 for discussion on the section index width.
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300.0f;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
