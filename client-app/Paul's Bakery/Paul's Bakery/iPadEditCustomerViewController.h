//
//  iPadEditCustomerViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/21/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Form.h"

typedef enum {
    customerEditModeAdd = 0,
    customerEditModeEdit = 1
} customerEditMode;


@interface iPadEditCustomerViewController : UITableViewController {
    customerEditMode currentMode;
    Form *form;
}

-(void)setViewMode:(customerEditMode)mode;

@end
