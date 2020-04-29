//
//  iPadCalculationSummaryViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculationViewItemCell.h"
#import "OrderManager.h"
#import "iPadCalculationAddItemViewController.h"

@protocol SummaryViewDelegate <NSObject>
@optional

-(void)didDeleteItemFromEditingOrder;

@end

@interface iPadCalculationSummaryViewController : UITableViewController {
    iPadCalculationAddItemViewController *addItemView;
}

@property (nonatomic, strong) id<SummaryViewDelegate> delegate;

-(void)didFinishEditingOrder;
-(void)didFinishSubmittingOrder;
-(void)useAddItemView:(iPadCalculationAddItemViewController *)v;

@end
