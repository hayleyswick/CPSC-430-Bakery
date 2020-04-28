//
//  iPadCalculationViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadCalculationViewController.h"

@interface iPadCalculationViewController ()

@end

@implementation iPadCalculationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Calculate" image:[UIImage imageNamed:@"calculator.png"] tag:1];
        if (!addItemView) {
            addItemView = [[iPadCalculationAddItemViewController alloc] initWithNibName:@"iPadCalculationAddItemViewController" bundle:nil];
            addItemView.delegate = self;
        }
        if (!summaryView) {
            summaryView = [[iPadCalculationSummaryViewController alloc] initWithNibName:@"iPadCalculationSummaryViewController" bundle:nil];
            [summaryView useAddItemView:addItemView];
            summaryView.delegate = self;
        }
        if(!resultView ) {
            resultView = [[iPadCalculationResultViewController alloc] initWithNibName:@"iPadCalculationResultViewController" bundle:nil];
            [resultView setSummaryTableView:summaryView];
            [resultView useAddItemView:addItemView];
            resultView.delegate = self;
        }
        UINavigationController *mainNavController = [[UINavigationController alloc] initWithRootViewController:resultView];
        UINavigationController *secondaryNavController = [[UINavigationController alloc] initWithRootViewController:summaryView];
        
        [self setViewControllers:@[secondaryNavController, mainNavController]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didFinishEditingWithItem:(OrderItem *)item {
    [[[OrderManager sharedInstance] editingOrder] addItem:item];
    [summaryView didFinishEditingOrder];
    [resultView didFinishEditingOrder];
}
-(void)didDeleteItemFromEditingOrder {
    [resultView didFinishEditingOrder];
}
-(void)beginOrderSubmission {
    if (!editOrderView) {
        editOrderView = [[iPadEditOrderViewController alloc] initWithNibName:@"iPadEditOrderViewController" bundle:nil];
        editOrderView.delegate = self;
    }
    
    if (!selectCustomerView) {
        selectCustomerView = [[iPadSelectCustomerViewController alloc] initWithNibName:@"iPadSelectCustomerViewController" bundle:nil];
        selectCustomerView.editOrderView = editOrderView;
    }
    SheetNavigationController *selectCustomerViewNav = [[SheetNavigationController alloc] initWithRootViewController:selectCustomerView];
    [self presentViewController:selectCustomerViewNav animated:YES completion:nil];
}
-(void)didFinishEditingOrder:(Order *)o {
    [[[OrderManager sharedInstance] editingOrder].items removeAllObjects];
    [summaryView didFinishEditingOrder];
    [resultView didFinishEditingOrder];
}
@end
