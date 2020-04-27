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
        [self.noDataView removeFromSuperview];
    } else {
        [self.view addSubview:self.noDataView];
    }
}
- (IBAction)showEditOrderInfoView:(id)sender {
    if (!selectCustomerView) {
        selectCustomerView = [[iPadSelectCustomerViewController alloc] initWithNibName:@"iPadSelectCustomerViewController" bundle:nil];
    }
    SheetNavigationController *selectCustomerViewNav = [[SheetNavigationController alloc] initWithRootViewController:selectCustomerView];
    [self presentViewController:selectCustomerViewNav animated:YES completion:nil];
}
@end
