//
//  WindowManager.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/2/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "WindowManager.h"

@implementation WindowManager

-(id)init {
    self = [super init];
    [BakeryCalculatorController sharedInstance].loginDelegate = self;
    [BakeryCalculatorController sharedInstance].errorDelegate = self;
    return self;
}
-(id)initWithRootWindow:(UIWindow *)win {
    self = [self init];
    self.window = win;
    return self;
}
-(void)loadInitialView {
    if ([[BakeryCalculatorController sharedInstance] loggedInUser]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            if (!iPadAdminVC) {
                iPadAdminVC = [[iPadAdminViewController alloc] initWithNibName:@"iPadAdminViewController" bundle:nil];
            }
            [self.window setRootViewController:iPadAdminVC];
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            if (!iPadLoginVC) {
                iPadLoginVC = [[iPadLoginViewController alloc] initWithNibName:@"iPadLoginViewController" bundle:nil];
            }
            [self.window setRootViewController:iPadLoginVC];
        }
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}
-(void)animateToView:(UIViewController *)view {
    if(UIInterfaceOrientationIsLandscape(self.window.rootViewController.interfaceOrientation)) {
        [UIView transitionWithView:self.window
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromBottom
                        animations:^{ [self.window setRootViewController:view]; }
                        completion:nil];
    }
    else {
        [UIView transitionWithView:self.window
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{ [self.window setRootViewController:view]; }
                        completion:nil];
    }
}
-(void)didLoginAsUser:(User *)user {
    switch (user.type) {
        case userTypeAdmin: {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                if (!iPadAdminVC) {
                    iPadAdminVC = [[iPadAdminViewController alloc] initWithNibName:@"iPadAdminViewController" bundle:nil];
                }
                
                [self animateToView:iPadAdminVC];
            }
            break;
        }
        case userTypeBaker:
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                if (!iPadAdminVC) {
                    iPadAdminVC = [[iPadAdminViewController alloc] initWithNibName:@"iPadAdminViewController" bundle:nil];
                }
                [self animateToView:iPadAdminVC];
            }
            break;
        default: {
            
            break;
        }
    }
}

-(void)handleError:(NSString *)err_code{
    NSString *title = @"";
    NSString *info = @"";
    if ([err_code isEqualToString:@"incorrect_login"]) {
        title = @"Login Invalid";
        info = @"The username or password you have entered is invalid";
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:info delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}
@end
