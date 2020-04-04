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
    if ([[[OrderManager sharedInstance] editingOrder] getItems].count < 1) {
        [self.view addSubview:self.noDataView];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSummaryTableView:(iPadCalculationSummaryViewController *)view {
    summaryTableView = view;
}
-(IBAction)showAddItemView:(id)sender {
    if (!addItemView) {
        addItemView = [[iPadCalculationAddItemViewController alloc] initWithNibName:@"iPadCalculationAddItemViewController" bundle:nil];
        addItemView.modalPresentationStyle = UIModalPresentationFormSheet;
        addItemView.delegate = self;
    }
    [addItemView clear];
    [self presentViewController:addItemView animated:YES completion:nil];
}
-(void)didFinishEditingWithItem:(OrderItem *)item {
    [[[OrderManager sharedInstance] editingOrder] addItem:item];
    [summaryTableView didFinishEditingOrder];
    [self.noDataView removeFromSuperview];
}
@end
