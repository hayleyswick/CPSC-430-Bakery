//
//  iPadEditUserFormViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadEditUserFormViewController.h"

@interface iPadEditUserFormViewController ()

@end

@implementation iPadEditUserFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initForm];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initForm {
    form = [[Form alloc] init];
    FormSection *type = [[FormSection alloc] init];
    FormItem *itm = [[FormItem alloc] initWithIdentifier:@"test" withPlaceholder:@"User Type" withSecurity:NO allowEditing:YES];
    itm.type = formItemTypeSelection;
    [itm addSelectionItem:[[FormItemSelection alloc] initWithSelectionText:@"Admin" selected:NO]];
    [itm addSelectionItem:[[FormItemSelection alloc] initWithSelectionText:@"Baker" selected:YES]];
    [type addItem:itm];
    
    [form addSection:type];
}


@end
