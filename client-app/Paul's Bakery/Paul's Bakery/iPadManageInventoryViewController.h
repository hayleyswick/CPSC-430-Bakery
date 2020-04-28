//
//  iPadManageInventoryViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/27/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InventoryManager.h"

#define kVanillaBatter "vanilla"
#define kChocolateBatter "chocolate"

@interface iPadManageInventoryViewController : UIViewController <UITextFieldDelegate, InventoryManagerDelegate> {
    Inventory *batterInventory;
}
- (IBAction)vanillaStepperChanged:(id)sender;
- (IBAction)chocolateStepperChanged:(id)sender;
- (IBAction)closeView:(id)sender;
- (IBAction)updateInventory:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *vanillaBatterDetailView;
@property (strong, nonatomic) IBOutlet UIView *chocolateBatterDetailView;
@property (strong, nonatomic) IBOutlet UIStepper *vanillaValueStepper;
@property (strong, nonatomic) IBOutlet UIStepper *chocolateValueStepper;
@property (strong, nonatomic) IBOutlet UITextField *vanillaValueField;
@property (strong, nonatomic) IBOutlet UITextField *chocolateValueField;

@end
