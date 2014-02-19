//
//  RMDynamicItemCell.h
//  ColorTilt
//
//  Created by Ryan Mathews on 2/12/14.
//  Copyright (c) 2014 Ryan Mathews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMDynamicItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
