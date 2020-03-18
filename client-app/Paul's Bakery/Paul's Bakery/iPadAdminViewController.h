//
//  iPadAdminViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/10/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadSummaryViewController.h"
#import "iPadLogViewController.h"
#import "iPadCalculationViewController.h"

@interface iPadAdminViewController : UITabBarController {
    NSMutableArray *tabbedViews;
}

@end
