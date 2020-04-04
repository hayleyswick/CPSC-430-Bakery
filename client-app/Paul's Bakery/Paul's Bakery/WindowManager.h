//
//  WindowManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BakeryCalculatorController.h"
#import "iPadLoginViewController.h"
#import "iPadAdminViewController.h"

@interface WindowManager : NSObject <BakeryCalculatorLoginDelegate, BakeryCalculatorErrorDelegate> {
    iPadAdminViewController *iPadAdminVC;
    iPadLoginViewController *iPadLoginVC;
}

@property (nonatomic, strong) UIWindow *window;

-(id)init;
-(id)initWithRootWindow:(UIWindow *)win;
-(void)loadInitialView;

@end
