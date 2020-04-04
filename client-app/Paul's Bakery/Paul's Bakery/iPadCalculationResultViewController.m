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
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Add Item" style:UIBarButtonItemStyleDone target:self action:@selector(showAddItemView)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showAddItemView {
    if (!addItemView) {
        addItemView = [[iPadCalculationAddItemViewController alloc] initWithNibName:@"iPadCalculationAddItemViewController" bundle:nil];
        addItemView.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self presentViewController:addItemView animated:YES completion:nil];
}
@end
