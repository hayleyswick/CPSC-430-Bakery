//
//  AppDelegate.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/10/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadMainViewController.h"
#import "iPadAdminViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    iPadMainViewController *iPadMvc;
    iPadAdminViewController *testVC;
}
@property (strong, nonatomic) UIWindow *window;

@end
