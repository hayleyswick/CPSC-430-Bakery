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
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome, %@!", [[[LoginManager sharedInstance] loggedInUser] firstname]];
}
-(void)viewDidAppear:(BOOL)animated {
    [UserManager sharedInstance].delegate = self;
    [[UserManager sharedInstance] retrieveUpdatedDataForUser:[[LoginManager sharedInstance] loggedInUser]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didUpdateInventoryData {
    batterInventory = [[InventoryManager sharedInstance] getInventoryWithID:@kInventoryIDBatter];
    if (batterInventory) {
        InventoryItem *vanilla = [batterInventory getItemWithIdentifier:@kInventoryItemVanillaBatter];
        InventoryItem *chocolate = [batterInventory getItemWithIdentifier:@kInventoryItemChocolateBatter];
        [self.vanillaBatterQuantityLabel setText:[NSString stringWithFormat:@"%g LBS", vanilla.quantity]];
        [self.chocolateBatterQuantityLabel setText:[NSString stringWithFormat:@"%g LBS", chocolate.quantity]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        [formatter setDateFormat:@"M/d/yyyy 'at' h:mm a"];
        if (batterInventory.dateCounted) {
            [self.lastUpdateLabel setText:[NSString stringWithFormat:@"Last counted on %@", [formatter stringFromDate:batterInventory.dateCounted]]];
        }
    }
}
-(void)userDataWasUpdated {
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome, %@!", [[[LoginManager sharedInstance] loggedInUser] firstname]];
    [InventoryManager sharedInstance].delegate = self;
    [[InventoryManager sharedInstance] fetchCurrentInventoryData];
}
@end
