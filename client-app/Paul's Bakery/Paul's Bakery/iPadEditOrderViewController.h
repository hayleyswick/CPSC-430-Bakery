//
//  iPadEditOrderViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/5/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerTableViewCell.h"
#import "Customer.h"
#import "OrderManager.h"

#define textViewCellHeight 155

@protocol EditOrderViewDelegate <NSObject>
@optional
-(void)didFinishEditingOrder:(Order *)o;
@end

typedef enum {
    editOrderSectionCustomer = 0,
    editOrderSectionNotes = 1
} editOrderSection;

typedef enum {
    orderEditModeAdd = 0,
    orderEditModeEdit = 1
} orderEditMode;

@interface iPadEditOrderViewController : UITableViewController <OrderManagerDelegate> {
    Customer *selectedCustomer;
    UITextView *notesTextView;
}

@property (nonatomic, strong) id <EditOrderViewDelegate> delegate;

@property orderEditMode currentMode;

-(void)setSelectedCustomer:(Customer *)cust;

@end
