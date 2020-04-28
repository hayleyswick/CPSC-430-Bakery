//
//  iPadManageInventoryViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/27/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadManageInventoryViewController.h"

@interface iPadManageInventoryViewController ()

@end

@implementation iPadManageInventoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated {
    [InventoryManager sharedInstance].delegate = self;
    [[InventoryManager sharedInstance] fetchCurrentInventoryData];
    [self updateValueSteppers];
    [self updateValueStrings];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.vanillaValueField setDelegate:self];
    [self.chocolateValueField setDelegate:self];
    [self.vanillaBatterDetailView.layer setCornerRadius:20];
    [self.chocolateBatterDetailView.layer setCornerRadius:20];
    [self.chocolateValueStepper setStepValue:1.0];
    [self.vanillaValueStepper setStepValue:1.0];
    [self.vanillaValueField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.chocolateValueField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}
-(void)didUpdateInventoryData {
    batterInventory = [[InventoryManager sharedInstance] getInventoryWithID:@kInventoryIDBatter];
    if (batterInventory) {
        [self updateValueStrings];
        [self updateValueSteppers];
    }
}
-(void)inventoryDataWasUpdated {
    [self closeView:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateValueStrings {
    [self.vanillaValueField setText:[NSString stringWithFormat:@"%g", [batterInventory getItemWithIdentifier:@kInventoryItemVanillaBatter].quantity]];
    [self.chocolateValueField setText:[NSString stringWithFormat:@"%g", [batterInventory getItemWithIdentifier:@kInventoryItemChocolateBatter].quantity]];
}
-(void)updateValueSteppers {
    [self.vanillaValueStepper setValue:[batterInventory getItemWithIdentifier:@kInventoryItemVanillaBatter].quantity];
    [self.chocolateValueStepper setValue:[batterInventory getItemWithIdentifier:@kInventoryItemChocolateBatter].quantity];
}
-(void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.vanillaValueField) {
        [batterInventory getItemWithIdentifier:@kInventoryItemVanillaBatter].quantity = [[self.vanillaValueField text] doubleValue];
    } else if (textField == self.chocolateValueField) {
        [batterInventory getItemWithIdentifier:@kInventoryItemChocolateBatter].quantity = [[self.chocolateValueField text] doubleValue];
    }
    [self updateValueSteppers];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!string.length) {
        return YES;
    }
    
    if ([string rangeOfString:@"."].location != NSNotFound) {
        return YES;
    }
    
    if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound) {
        return NO;
    }
    return YES;
}
- (IBAction)vanillaStepperChanged:(id)sender {
    [batterInventory getItemWithIdentifier:@kInventoryItemVanillaBatter].quantity = [self.vanillaValueStepper value];
    [self updateValueStrings];
}

- (IBAction)chocolateStepperChanged:(id)sender {
    [batterInventory getItemWithIdentifier:@kInventoryItemChocolateBatter].quantity = [self.chocolateValueStepper value];
    [self updateValueStrings];
}

- (IBAction)closeView:(id)sender {
    [[InventoryManager sharedInstance] discardInventoryEditsForInventory:batterInventory];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)updateInventory:(id)sender {
    [InventoryManager sharedInstance].delegate = self;
    [[InventoryManager sharedInstance] saveInventoryEditsForInventory:batterInventory];
}
@end
