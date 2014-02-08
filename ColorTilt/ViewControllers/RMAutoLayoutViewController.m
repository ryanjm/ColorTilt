//
//  RMAutoLayoutViewController.m
//  ColorTilt
//
//  Created by Ryan Mathews on 2/7/14.
//  Copyright (c) 2014 Ryan Mathews. All rights reserved.
//

#import "RMAutoLayoutViewController.h"

@interface RMAutoLayoutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation RMAutoLayoutViewController

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

    self.textView.scrollEnabled = NO;
    [self.textView needsUpdateConstraints];
    
    self.scrollViewHeightConstraint.constant = self.view.bounds.size.height;
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"This is a really long string so I don't have to keep typing it in. I can type it once and then just reuse it. Hopefully. And this should be enough to make it go to multiple lines and require scrolling to kick in.";
    
    [self observeKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - Actions

- (IBAction)startStopButtonTapped:(id)sender {
    if ([self.textView isFirstResponder])
        [self.textView resignFirstResponder];
    else
        [self.textView becomeFirstResponder];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [self.textView needsUpdateConstraints];
    
    self.textLabel.text = textView.text;
    
    NSLog(@"%@", NSStringFromCGRect(self.scrollView.frame));
    NSLog(@"%@", NSStringFromCGSize(self.scrollView.contentSize));
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height = keyboardFrame.size.height;
    CGFloat viewHeight = self.view.bounds.size.height;
    self.scrollViewHeightConstraint.constant = viewHeight-height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGFloat viewHeight = self.view.bounds.size.height;
    self.scrollViewHeightConstraint.constant = viewHeight;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
