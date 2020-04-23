//
//  iPadEditOrderViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/5/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerTableViewCell.h"

#define textViewCellHeight 155

typedef enum {
    editOrderSectionCustomer = 0,
    editOrderSectionNotes = 1
} editOrderSection;

@interface iPadEditOrderViewController : UITableViewController 

@end
