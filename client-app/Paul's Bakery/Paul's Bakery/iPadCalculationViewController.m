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
        if (!summaryView) {
            summaryView = [[iPadCalculationSummaryViewController alloc] initWithNibName:@"iPadCalculationSummaryViewController" bundle:nil];
        }
        if(!resultView ) {
            resultView = [[iPadCalculationResultViewController alloc] initWithNibName:@"iPadCalculationResultViewController" bundle:nil];
            [resultView setSummaryTableView:summaryView];
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

@end
