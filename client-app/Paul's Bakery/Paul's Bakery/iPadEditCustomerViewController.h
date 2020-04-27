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


@interface iPadEditCustomerViewController : iPadModalFormEditor <CustomerManagerDelegate> {
    customerEditMode currentMode;
    iPadEditOrderViewController *editOrderView;
    Customer *editingCustomer;
}

-(void)setViewMode:(customerEditMode)mode;
-(void)setEditingCustomer:(Customer *)cust;

@end
