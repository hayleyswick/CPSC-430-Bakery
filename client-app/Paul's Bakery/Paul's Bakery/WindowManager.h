//
//  WindowManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginManager.h"
#import "iPadLoginViewController.h"
#import "iPadAdminViewController.h"
#import "iPhonePlaceholderViewController.h"

typedef enum {
    animationNone = 0,
    animationFlipFromLeft = 1,
    animationFlipFromRight = 2
}animation;

@interface WindowManager : NSObject <LoginManagerDelegate> {
    iPadAdminViewController *iPadAdminVC;
    iPadLoginViewController *iPadLoginVC;
}

@property (nonatomic, strong) UIWindow *window;

-(id)init;
-(id)initWithRootWindow:(UIWindow *)win;
-(void)loadInitialView;

@end
