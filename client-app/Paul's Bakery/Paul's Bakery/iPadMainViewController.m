//
//  iPadMainViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/10/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadMainViewController.h"

@interface iPadMainViewController ()

@end

@implementation iPadMainViewController

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
    // Do any additional setup after loading the view from its nib.
    [self initViews];
}
-(void)initViews {
    
    if (!adminView) {
        adminView = [[iPadAdminViewController alloc] initWithNibName:@"iPadAdminViewController" bundle:nil];
    }
    [self.view addSubview:adminView.view];
    //self.viewControllers = @[adminView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
