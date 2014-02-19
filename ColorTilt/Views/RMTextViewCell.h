//
//  RMTextViewCell.h
//  ColorTilt
//
//  Created by Ryan Mathews on 2/13/14.
//  Copyright (c) 2014 Ryan Mathews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTextViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtextLabel;


@end
