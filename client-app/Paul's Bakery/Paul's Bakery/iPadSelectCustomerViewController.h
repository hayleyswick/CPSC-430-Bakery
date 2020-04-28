//
//  iPadSelectCustomerViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/21/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerTableViewCell.h"
#import "iPadEditCustomerViewController.h"
#import "iPadEditOrderViewController.h"
#import "CustomerManager.h"

@interface iPadSelectCustomerViewController : UITableViewController <CustomerManagerDelegate> {
    iPadEditCustomerViewController *editCustomerView;
    NSArray *preUpdate;
}

@property iPadEditOrderViewController *editOrderView;
@property (strong, nonatomic) IBOutlet UIView *noDataView;
- (IBAction)addNewCustomer:(id)sender;

@end
