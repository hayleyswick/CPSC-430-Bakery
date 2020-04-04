//
//  iPadAdminViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/10/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadAdminViewController.h"

@interface iPadAdminViewController ()

@end

@implementation iPadAdminViewController

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
    [self initViews];
}
-(void)initViews {
    if (!tabbedViews) {
        tabbedViews = [[NSMutableArray alloc] init];
    }
    
    [tabbedViews addObject:[[UINavigationController alloc] initWithRootViewController:[[iPadSummaryViewController alloc] initWithNibName:@"iPadSummaryViewController" bundle:nil]]];
    [tabbedViews addObject:[[UINavigationController alloc] initWithRootViewController:[[iPadLogViewController alloc] initWithNibName:@"iPadLogViewController" bundle:nil]]];
    //[tabbedViews addObject:[[UINavigationController alloc] initWithRootViewController:[[iPadCalculationViewController alloc] initWithNibName:@"iPadCalculationViewController" bundle:nil]]];
    [tabbedViews addObject:[[iPadCalculationViewController alloc] initWithNibName:@"iPadCalculationViewController" bundle:nil]];
    
    self.viewControllers = tabbedViews;
    
    //self.selectedViewController = [tabbedViews objectAtIndex:0];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
