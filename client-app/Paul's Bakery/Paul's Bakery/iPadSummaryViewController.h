//
//  iPadSummaryViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/10/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginManager.h"
#import "UserManager.h"
#import "InventoryManager.h"

@interface iPadSummaryViewController : UIViewController <UserManagerDelegate, InventoryManagerDelegate> {
    Inventory *batterInventory;
}
@property (strong, nonatomic) IBOutlet UIView *batterInventoryView;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *vanillaBatterQuantityLabel;
@property (strong, nonatomic) IBOutlet UILabel *chocolateBatterQuantityLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastUpdateLabel;

@end
