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
#import "iPadCalculationAddItemViewController.h"
#import "iPadSelectCustomerViewController.h"
#import "iPadEditCustomerViewController.h"
#import "SheetNavigationController.h"


@interface iPadCalculationViewController : UISplitViewController <AddOrderItemDelegate, SummaryViewDelegate, CalculationResultDelegate, EditOrderViewDelegate, InventoryManagerDelegate> {
    iPadCalculationSummaryViewController *summaryView;
    iPadCalculationResultViewController *resultView;
    iPadCalculationAddItemViewController *addItemView;
    iPadSelectCustomerViewController *selectCustomerView;
    iPadEditOrderViewController *editOrderView;
    
    int tempItemID;
}

@end
