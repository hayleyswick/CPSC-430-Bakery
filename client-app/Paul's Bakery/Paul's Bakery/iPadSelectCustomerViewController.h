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

@interface iPadSelectCustomerViewController : UITableViewController {
    iPadEditCustomerViewController *editCustomerView;
    iPadEditOrderViewController *editOrderView;
}

@end
