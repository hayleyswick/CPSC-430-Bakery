//
//  iPadLogDetailViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/26/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerTableViewCell.h"
#import "MultiDetailTableViewCell.h"
#import "OrderManager.h"
#import "iPadEditCustomerViewController.h"

#define textViewCellHeight 155

typedef enum {
    orderDetailSectionCustomer = 0,
    orderDetailSectionItems = 1,
    orderDetailSectionNotes = 2
}orderDetailSection;

@interface iPadLogDetailViewController : UITableViewController <OrderManagerDelegate> {
    UITextView *notesTextView;
    Order *selectedOrder;
    NSArray *preUpdate;
    iPadEditCustomerViewController *editCustomerView;
}

-(void)setSelectedOrder:(Order *)o;

@end
