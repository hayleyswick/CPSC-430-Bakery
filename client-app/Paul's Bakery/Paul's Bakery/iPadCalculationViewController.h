//
//  iPadCalculationViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadCalculationSummaryViewController.h"
#import "iPadCalculationResultViewController.h"


@interface iPadCalculationViewController : UISplitViewController {
    iPadCalculationSummaryViewController *summaryView;
    iPadCalculationResultViewController *resultView;
}

@end
