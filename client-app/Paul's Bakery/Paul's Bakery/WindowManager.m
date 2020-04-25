//
//  WindowManager.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
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
            [self setActiveViewController:iPadAdminVC withAnimation:NO];
        }
        
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            if (!iPadLoginVC) {
                iPadLoginVC = [[iPadLoginViewController alloc] initWithNibName:@"iPadLoginViewController" bundle:nil];
            }
            [self setActiveViewController:iPadLoginVC withAnimation:NO];
        }
    }
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}
-(void)setActiveViewController:(UIViewController *)controller withAnimation:(BOOL)animate {
    
    UIViewController *wrapperVC = [[UIViewController alloc] init];
    [wrapperVC.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:235.0/255.0 blue:219.0/255.0 alpha:1.0f]];
    [wrapperVC.view addSubview:controller.view];
    
    if (animate) {
        UIViewAnimationOptions opt;
        
        if(UIInterfaceOrientationIsLandscape(self.window.rootViewController.interfaceOrientation)) {
            opt = UIViewAnimationOptionTransitionFlipFromBottom;
        }
        else {
            opt = UIViewAnimationOptionTransitionFlipFromRight;
        }
        
        [UIView transitionWithView:self.window
                          duration:0.5
                           options:opt
                        animations:^{ [self.window setRootViewController:wrapperVC]; }
                        completion:nil];
    } else {
        [self.window setRootViewController:wrapperVC];
    }
}

-(void)didLoginAsUser:(User *)user {
    switch (user.type) {
        case userTypeAdmin: {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                if (!iPadAdminVC) {
                    iPadAdminVC = [[iPadAdminViewController alloc] initWithNibName:@"iPadAdminViewController" bundle:nil];
                }
                
                [self setActiveViewController:iPadAdminVC withAnimation:YES];
            }
            break;
        }
        case userTypeBaker:
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                if (!iPadAdminVC) {
                    iPadAdminVC = [[iPadAdminViewController alloc] initWithNibName:@"iPadAdminViewController" bundle:nil];
                }
                [self setActiveViewController:iPadAdminVC withAnimation:YES];
            }
            break;
        default: {
            
            break;
        }
    }
}

-(void)handleError:(NSString *)err_code {
    NSString *title = @"Unknown Error";
    NSString *info = @"An unknown error occurred.";
    if ([err_code isEqualToString:@"incorrect_login"]) {
        title = @"Login Invalid";
        info = @"The username or password you have entered is invalid.";
    } else if ([err_code isEqualToString:@"conn_error"]) {
        title = @"Network Error";
        info = @"The server could not be reached. Please check your Internet connection and try again.";
    } else if ([err_code isEqualToString:@"invalid_session"]) {
        title = @"Invalid Session";
        info = @"Your current session has expired. You will now be logged out.";
    } else if ([err_code isEqualToString:@"customer_exists"]) {
        title = @"Customer Exists";
        info = @"The specified customer has already been added.";
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:info delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}


@end
