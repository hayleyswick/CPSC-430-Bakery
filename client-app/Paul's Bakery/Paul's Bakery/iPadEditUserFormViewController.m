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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveUserData)];
    self.navigationItem.title = @"Edit User";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)saveUserData {
    BOOL valid = YES;
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    for (FormItem *i in [form getAllItems]) {
        if (i.value == nil || [i.value isEqualToString:@""]) {
            valid = NO;
        }
        [d setObject:i.value forKey:i.identifier];
    }
    if (valid) {
        [editingUser updateWithDict:d];
        [UserManager sharedInstance].delegate = self;
        [[UserManager sharedInstance] saveDataForUser:editingUser];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Info" message:@"Please enter all the requested information to perform this operation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}
-(void)didSaveUserData {
    [self.delegate didFinishEditingUserAtIndexPath:editingIndexPath];
    [[self navigationController] popViewControllerAnimated:YES];
}
-(void)initForm {
    form = [[Form alloc] init];
    
    FormSection *username = [[FormSection alloc] init];
    username.title = @"Username";
    [username addItem:[[FormItem alloc] initWithIdentifier:@kUsername withPlaceholder:@"Username" withSecurity:NO allowEditing:YES]];
    [form addSection:username];
    
    FormSection *name = [[FormSection alloc] init];
    name.title = @"Name";
    [name addItem:[[FormItem alloc] initWithIdentifier:@kFirstname withPlaceholder:@"First Name" withSecurity:NO allowEditing:YES]];
    [name addItem:[[FormItem alloc] initWithIdentifier:@kLastname withPlaceholder:@"Last Name" withSecurity:NO allowEditing:YES]];
    [form addSection:name];
    
    FormSection *type = [[FormSection alloc] init];
    FormItem *itm = [[FormItem alloc] initWithIdentifier:@kType withPlaceholder:@"User Type" withSecurity:NO allowEditing:YES];
    itm.type = formItemTypeSelection;
    [itm addSelectionItem:[[FormItemSelection alloc] initWithSelectionText:@"Admin" selected:NO]];
    [itm addSelectionItem:[[FormItemSelection alloc] initWithSelectionText:@"Baker" selected:YES]];
    [type addItem:itm];
    
    [form addSection:type];
}
-(void)beginEditingUser:(User *)u atIndexPath:(NSIndexPath *)editing {
    editingIndexPath = editing;
    editingUser = u;
    for (NSString *key in [u dictRepresentation].allKeys) {
        FormItem *itm = [form getItemWithIdentifier:key];
        if (itm) {
            itm.value = [[u dictRepresentation] objectForKey:key];
        }
    }
    [self.tableView reloadData];
}

@end
