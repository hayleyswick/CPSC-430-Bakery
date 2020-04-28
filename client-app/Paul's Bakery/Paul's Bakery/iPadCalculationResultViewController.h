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

@protocol CalculationResultDelegate <NSObject>
@optional
-(void)beginOrderSubmission;
@end

@interface iPadCalculationResultViewController : UIViewController <AddOrderItemDelegate> {
    iPadCalculationSummaryViewController *summaryTableView;
    iPadCalculationAddItemViewController *addItemView;
}

@property (nonatomic, strong) id<CalculationResultDelegate> delegate;

-(void)setSummaryTableView:(iPadCalculationSummaryViewController *)view;
-(IBAction)showAddItemView:(id)sender;
-(IBAction)showEditOrderInfoView:(id)sender;
-(void)useAddItemView:(iPadCalculationAddItemViewController *)v;
-(void)didFinishEditingOrder;
@property (strong, nonatomic) IBOutlet UIView *noDataView;

@end
