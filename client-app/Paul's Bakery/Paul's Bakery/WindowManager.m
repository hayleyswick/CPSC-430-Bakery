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
    [LoginManager sharedInstance].delegate = self;
    return self;
}

-(id)initWithRootWindow:(UIWindow *)win {
    self = [self init];
    self.window = win;
    return self;
}

-(void)loadInitialView {
    if ([[LoginManager sharedInstance] loggedInUser]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            iPadAdminVC = [[iPadAdminViewController alloc] initWithNibName:@"iPadAdminViewController" bundle:nil];
            [self setActiveViewController:iPadAdminVC withAnimation:animationNone];
        }
        
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            iPadLoginVC = [[iPadLoginViewController alloc] initWithNibName:@"iPadLoginViewController" bundle:nil];
            [self setActiveViewController:iPadLoginVC withAnimation:animationNone];
        }
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        iPhonePlaceholderViewController *v = [[iPhonePlaceholderViewController alloc] initWithNibName:@"iPhonePlaceholderViewController" bundle:nil];
        [self setActiveViewController:v withAnimation:animationNone];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}
-(void)setActiveViewController:(UIViewController *)controller withAnimation:(animation)animationType {
    
    UIViewController *wrapperVC = [[UIViewController alloc] init];
    [wrapperVC.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:235.0/255.0 blue:219.0/255.0 alpha:1.0f]];
    [wrapperVC.view addSubview:controller.view];
    
    if (animationType != animationNone) {
        UIViewAnimationOptions opt;
        
        if (animationType == animationFlipFromRight) {
            if(UIInterfaceOrientationIsLandscape(self.window.rootViewController.interfaceOrientation)) {
                opt = UIViewAnimationOptionTransitionFlipFromBottom;
            }
            else {
                opt = UIViewAnimationOptionTransitionFlipFromRight;
            }
        } else if (animationType == animationFlipFromLeft) {
            if(UIInterfaceOrientationIsLandscape(self.window.rootViewController.interfaceOrientation)) {
                opt = UIViewAnimationOptionTransitionFlipFromTop;
            }
            else {
                opt = UIViewAnimationOptionTransitionFlipFromLeft;
            }
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
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        iPadAdminVC = [[iPadAdminViewController alloc] initWithNibName:@"iPadAdminViewController" bundle:nil];
        [self setActiveViewController:iPadAdminVC withAnimation:animationFlipFromRight];
    }
}

-(void)didLogoutSuccessfully {
    iPadLoginVC = [[iPadLoginViewController alloc] initWithNibName:@"iPadLoginViewController" bundle:nil];
    [self setActiveViewController:iPadLoginVC withAnimation:animationFlipFromLeft];
}


@end
