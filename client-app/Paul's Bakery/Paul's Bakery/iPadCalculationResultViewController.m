//
//  iPadCalculationResultViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadCalculationResultViewController.h"

@interface iPadCalculationResultViewController ()

@end

@implementation iPadCalculationResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Add Item" style:UIBarButtonItemStylePlain target:self action:@selector(showAddItemView:)]];
    if ([[[OrderManager sharedInstance] editingOrder] items].count < 1) {
        [self.view addSubview:self.noDataView];
    }
    [self.navigationItem setTitle:@"Calculation"];
    [self.vanillaSubview.layer setCornerRadius:20];
    [self.chocolateSubview.layer setCornerRadius:20];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSummaryTableView:(iPadCalculationSummaryViewController *)view {
    summaryTableView = view;
}
-(void)useAddItemView:(iPadCalculationAddItemViewController *)v{
    addItemView = v;
}
-(IBAction)showAddItemView:(id)sender {
    [addItemView setSelectionMode:selectionModeAdd];
    [addItemView clear];
    [self presentViewController:addItemView animated:YES completion:nil];
}
-(void)didFinishEditingOrder {
    if ([[[OrderManager sharedInstance] editingOrder] items].count > 0) {
        [self updateCalculationResults];
        [self.noDataView removeFromSuperview];
    } else {
        [self.view addSubview:self.noDataView];
    }
}
-(void)didFinishSubmittingOrder {
    
    [self didFinishEditingOrder];
}
- (IBAction)showEditOrderInfoView:(id)sender {
    [self.delegate beginOrderSubmission];
}
-(void)updateCalculationResults {
    [self.vanillaFullSheetLabel setText:[NSString stringWithFormat:@"%d", [[BatterCalculationManager sharedInstance] getNumberOfVanillaSheetsNeededForOrder:[[OrderManager sharedInstance] editingOrder]]]];
    [self.vanillaFullRoundLabel setText:[NSString stringWithFormat:@"%d", [[BatterCalculationManager sharedInstance] getNumberOfVanillaRoundsNeededForOrder:[[OrderManager sharedInstance] editingOrder]]]];
    [self.vanillaQuantityLabel setText:[NSString stringWithFormat:@"%g LBS", [[BatterCalculationManager sharedInstance] getVanillaBatterNeededForOrder:[[OrderManager sharedInstance] editingOrder]]]];
    [self.chocolateFullSheetLabel setText:[NSString stringWithFormat:@"%d", [[BatterCalculationManager sharedInstance] getNumberOfChocolateSheetsNeededForOrder:[[OrderManager sharedInstance] editingOrder]]]];
    [self.chocolateFullRoundLabel setText:[NSString stringWithFormat:@"%d", [[BatterCalculationManager sharedInstance] getNumberOfChocolateRoundsNeededForOrder:[[OrderManager sharedInstance] editingOrder]]]];
    [self.chocolateQuantityLabel setText:[NSString stringWithFormat:@"%g LBS", [[BatterCalculationManager sharedInstance] getChocolateBatterNeededForOrder:[[OrderManager sharedInstance] editingOrder]]]];
    
}
@end
