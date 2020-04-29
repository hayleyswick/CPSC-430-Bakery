//
//  iPadEditCustomerViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/21/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadModalFormEditor.h"
#import "CustomerManager.h"
#import "iPadEditOrderViewController.h"

typedef enum {
    customerEditModeAdd = 0,
    customerEditModeEdit = 1,
    customerEditModeView = 2
} customerEditMode;

@protocol EditCustomerViewDelegate <NSObject>
@optional
-(void)didFinishEditingCustomerAtIndexPath:(NSIndexPath *)path;
@end

@interface iPadEditCustomerViewController : iPadModalFormEditor <CustomerManagerDelegate> {
    customerEditMode currentMode;
    Customer *editingCustomer;
    NSIndexPath *editingIndexPath;
}

@property (nonatomic, strong) id <EditCustomerViewDelegate> delegate;

@property iPadEditOrderViewController *editOrderView;
@property BOOL inOrderFlow;

-(void)setViewMode:(customerEditMode)mode;
-(void)beginEditingCustomer:(Customer *)cust atIndexPath:(NSIndexPath *)path;

@end
