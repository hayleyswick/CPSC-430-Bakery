//
//  iPadLoginViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/2/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadLoginViewController.h"

@interface iPadLoginViewController ()

@end

@implementation iPadLoginViewController

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
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor grayColor].CGColor;
    border.frame = CGRectMake(10, self.usernameField.frame.size.height - borderWidth, self.usernameField.frame.size.width - 20, self.usernameField.frame.size.height);
    border.borderWidth = borderWidth;
    [self.usernameField.layer addSublayer:border];
    
    
    
    self.usernameField.clipsToBounds = YES;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.usernameField.layer.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.usernameField.layer.bounds;
    maskLayer.path = maskPath.CGPath;
    self.usernameField.layer.mask = maskLayer;
    

    
    
    self.passwordField.clipsToBounds = YES;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.passwordField.layer.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.passwordField.layer.bounds;
    maskLayer.path = maskPath.CGPath;
    self.passwordField.layer.mask = maskLayer;
    
    
}

-(void)keyboardWillShow:(NSNotification *)note
{
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
    {
        NSDictionary *userInfo = note.userInfo;
        NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationCurve curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
        
        CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect keyboardFrameForView = [self.view.superview convertRect:keyboardFrame fromView:nil];
        
        CGRect newViewFrame = self.view.frame;
        newViewFrame.origin.y = keyboardFrameForView.origin.y - (self.loginButton.frame.origin.y+self.loginButton.frame.size.height+20);
        
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
            self.view.frame = newViewFrame;
        } completion:nil];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyboardWillHide:(NSNotification *)note
{
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
    {
        NSDictionary *userInfo = note.userInfo;
        NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationCurve curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
        
        CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect keyboardFrameForView = [self.view.superview convertRect:keyboardFrame fromView:nil];
        
        CGRect newViewFrame = self.view.frame;
        newViewFrame.origin.y = keyboardFrameForView.origin.y - newViewFrame.size.height;
        
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
            self.view.frame = newViewFrame;
        } completion:nil];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    [[LoginManager sharedInstance] loginWithUsername:[self.usernameField text] withPassword:[self.passwordField text]];
}
@end
