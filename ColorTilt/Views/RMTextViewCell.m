//
//  RMTextViewCell.m
//  ColorTilt
//
//  Created by Ryan Mathews on 2/13/14.
//  Copyright (c) 2014 Ryan Mathews. All rights reserved.
//

#import "RMTextViewCell.h"

@implementation RMTextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.contentInset = UIEdgeInsetsZero;
}

@end
