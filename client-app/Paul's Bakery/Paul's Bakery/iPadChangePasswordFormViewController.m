//
//  iPadChangePasswordFormViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/26/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadChangePasswordFormViewController.h"

@interface iPadChangePasswordFormViewController ()

@end

@implementation iPadChangePasswordFormViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFormSheet;
        [self initForm];
    }
    return self;
}
-(void)initForm {
    form = [[Form alloc] init];
    FormSection *oldPW = [[FormSection alloc] init];
    FormItem *oldPWEntry = [[FormItem alloc] initWithIdentifier:@kOldPassword withPlaceholder:@"Old Password"withSecurity:YES allowEditing:YES];
    [oldPW addItem:oldPWEntry];
    [form addSection:oldPW];
    
    FormSection *newPW = [[FormSection alloc] init];
    FormItem *newPWEntry = [[FormItem alloc] initWithIdentifier:@kNewPassword withPlaceholder:@"New Password" withSecurity:YES allowEditing:YES];
    FormItem *newPWConfirm = [[FormItem alloc] initWithIdentifier:@kNewPasswordConfirmation withPlaceholder:@"Confirm" withSecurity:YES allowEditing:YES];
    [newPW addItem:newPWEntry];
    [newPW addItem:newPWConfirm];
    [form addSection:newPW];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Change Password"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Change" style:UIBarButtonItemStyleDone target:self action:@selector(changePassword)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(closeView)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changePassword {
    
}


@end
