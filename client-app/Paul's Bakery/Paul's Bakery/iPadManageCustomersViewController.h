//
//  iPadManageCustomersViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerManager.h"
#import "CustomerTableViewCell.h"
#import "iPadEditCustomerViewController.h"

@interface iPadManageCustomersViewController : UITableViewController <CustomerManagerDelegate, EditCustomerViewDelegate> {
    NSArray *preUpdate;
}

@property (strong, nonatomic) IBOutlet UIView *noDataView;
- (IBAction)addNewCustomer:(id)sender;

@end
