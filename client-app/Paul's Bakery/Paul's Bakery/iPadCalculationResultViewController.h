//
//  iPadCalculationResultViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadCalculationSummaryViewController.h"
#import "iPadCalculationAddItemViewController.h"
#import "OrderManager.h"

@interface iPadCalculationResultViewController : UIViewController <AddOrderItemDelegate> {
    iPadCalculationSummaryViewController *summaryTableView;
    iPadCalculationAddItemViewController *addItemView;
}

-(void)setSummaryTableView:(iPadCalculationSummaryViewController *)view;
-(IBAction)showAddItemView:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *noDataView;

@end
