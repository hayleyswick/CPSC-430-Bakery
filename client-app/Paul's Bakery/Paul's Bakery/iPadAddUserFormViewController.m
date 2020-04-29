//
//  iPadAddUserFormViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadAddUserFormViewController.h"

@interface iPadAddUserFormViewController ()

@end

@implementation iPadAddUserFormViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self initForm];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addUser)];
    self.navigationItem.title = @"Add New User";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initForm {
    form = [[Form alloc] init];
    
    FormSection *name = [[FormSection alloc] init];
    name.title = @"Name";
    [name addItem:[[FormItem alloc] initWithIdentifier:@kFirstname withPlaceholder:@"First Name" withSecurity:NO allowEditing:YES]];
    [name addItem:[[FormItem alloc] initWithIdentifier:@kLastname withPlaceholder:@"Last Name" withSecurity:NO allowEditing:YES]];
    [form addSection:name];
    
    FormSection *username = [[FormSection alloc] init];
    username.title = @"Username";
    [username addItem:[[FormItem alloc] initWithIdentifier:@kUsername withPlaceholder:@"Username" withSecurity:NO allowEditing:YES]];
    [form addSection:username];
    
    FormSection *password = [[FormSection alloc] init];
    password.title = @"Password";
    [password addItem:[[FormItem alloc] initWithIdentifier:@kPassword withPlaceholder:@"Password" withSecurity:YES allowEditing:YES]];
    [password addItem:[[FormItem alloc] initWithIdentifier:@kPasswordConfirmation withPlaceholder:@"Confirm" withSecurity:YES allowEditing:YES]];
    [form addSection:password];
    
    FormSection *type = [[FormSection alloc] init];
    FormItem *itm = [[FormItem alloc] initWithIdentifier:@kType withPlaceholder:@"User Type" withSecurity:NO allowEditing:YES];
    itm.type = formItemTypeSelection;
    [itm addSelectionItem:[[FormItemSelection alloc] initWithSelectionText:@"Admin" selected:NO]];
    [itm addSelectionItem:[[FormItemSelection alloc] initWithSelectionText:@"Baker" selected:YES]];
    [type addItem:itm];
    
    [form addSection:type];
}
-(void)addUser {
    BOOL valid = YES;
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    for (FormItem *i in [form getAllItems]) {
        if (i.value == nil || [i.value isEqualToString:@""]) {
            valid = NO;
        }
        [d setObject:i.value forKey:i.identifier];
    }
    if (valid) {
        NSString *password = [form getItemWithIdentifier:@kPassword].value;
        if ([password isEqualToString:[form getItemWithIdentifier:@kPasswordConfirmation].value]) {
            User *u = [[User alloc] initWithDict:d];
            [UserManager sharedInstance].delegate = self;
            [[UserManager sharedInstance] addUser:u withPassword:password];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passwords Don't Match" message:@"The password entered and confirmation do not match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Info" message:@"Please enter all the requested information to perform this operation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)newUserWasAdded {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
