//
//  iPadSummaryViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/10/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadSummaryViewController.h"

@interface iPadSummaryViewController ()

@end

@implementation iPadSummaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Summary" image:[UIImage imageNamed:@"star.png"] tag:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.batterInventoryView.layer setCornerRadius:20];
    self.navigationItem.title = @"Paul's Bakery Batter Calculator";
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome, %@!", [[[BakeryCalculatorController sharedInstance] loggedInUser] firstname]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
