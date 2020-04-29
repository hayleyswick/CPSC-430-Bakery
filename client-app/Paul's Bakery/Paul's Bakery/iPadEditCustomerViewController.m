//
//  iPadEditCustomerViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/21/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadEditCustomerViewController.h"

@interface iPadEditCustomerViewController ()

@end

@implementation iPadEditCustomerViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFormSheet;
        currentMode = customerEditModeEdit;
        self.inOrderFlow = NO;
        [self initForm];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switch (currentMode) {
        case customerEditModeAdd:
            [self.navigationItem setTitle:@"Add New Customer"];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addCustomer)];
            break;
        case customerEditModeEdit:
            [self.navigationItem setTitle:@"Edit Customer"];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveCustomer)];
            break;
        case customerEditModeView:
            [self.navigationItem setTitle:@"Customer Details"];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
        default:
            break;
    }
}
-(void)initForm {
    
    BOOL editable = YES;
    if (currentMode == customerEditModeView) {
        editable = NO;
    }
    
    form = [[Form alloc] init];
    FormSection *name = [[FormSection alloc] init];
    name.title = @"Customer Name";
    [name addItem:[[FormItem alloc] initWithIdentifier:@kCustomerFirstname withPlaceholder:@"First Name" withSecurity:NO allowEditing:editable]];
    [name addItem:[[FormItem alloc] initWithIdentifier:@kCustomerLastname withPlaceholder:@"Last Name" withSecurity:NO allowEditing:editable]];
    [form addSection:name];
    FormSection *phone = [[FormSection alloc] init];
    phone.title = @"Phone Number";
    [phone addItem:[[FormItem alloc] initWithIdentifier:@kCustomerPhoneNumber withPlaceholder:@"Phone" withSecurity:NO allowEditing:editable]];
    [form addSection:phone];
    FormSection *address = [[FormSection alloc] init];
    address.title = @"Address";
    [address addItem:[[FormItem alloc] initWithIdentifier:@kCustomerStreet withPlaceholder:@"12345 Example Dr." withSecurity:NO allowEditing:editable]];
    [address addItem:[[FormItem alloc] initWithIdentifier:@kCustomerCity withPlaceholder:@"City" withSecurity:NO allowEditing:editable]];
    [address addItem:[[FormItem alloc] initWithIdentifier:@kCustomerState withPlaceholder:@"State" withSecurity:NO allowEditing:YES]];
    [address addItem:[[FormItem alloc] initWithIdentifier:@kCustomerZip withPlaceholder:@"ZIP Code" withSecurity:NO allowEditing:YES]];
    [form addSection:address];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setViewMode:(customerEditMode)mode {
    currentMode = mode;
    [self initForm];
}
-(void)beginEditingCustomer:(Customer *)cust atIndexPath:(NSIndexPath *)path {
    editingIndexPath = path;
    editingCustomer = cust;
    for (NSString *key in [cust dictRepresentation].allKeys) {
        FormItem *itm = [form getItemWithIdentifier:key];
        itm.value = [[cust dictRepresentation] objectForKey:key];
    }
    [self.tableView reloadData];
}
- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addCustomer {
    BOOL valid = YES;
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    for (FormItem *i in [form getAllItems]) {
        if (i.value == nil || [i.value isEqualToString:@""]) {
            valid = NO;
        }
        [d setObject:i.value forKey:i.identifier];
    }
    if (valid) {
        [CustomerManager sharedInstance].delegate = self;
        [[CustomerManager sharedInstance] addCustomer:[[Customer alloc] initWithDict:d]];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Info" message:@"Please enter all the requested information to perform this operation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}
-(void)saveCustomer {
    BOOL valid = YES;
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    for (FormItem *i in [form getAllItems]) {
        if (i.value == nil || [i.value isEqualToString:@""]) {
            valid = NO;
        }
        [d setObject:i.value forKey:i.identifier];
    }
    if (valid) {
        [editingCustomer updateWithDict:d];
        [CustomerManager sharedInstance].delegate = self;
        [[CustomerManager sharedInstance] saveDataForCustomer:editingCustomer];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Info" message:@"Please enter all the requested information to perform this operation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)customerWasAdded:(Customer *)cust {
    if (self.inOrderFlow) {
        if (!self.editOrderView) {
            self.editOrderView = [[iPadEditOrderViewController alloc] initWithNibName:@"iPadEditOrderViewController" bundle:nil];
        }
        [self.editOrderView setSelectedCustomer:cust];
        [self.navigationController pushViewController:self.editOrderView animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)didSaveCustomerData {
    [self.delegate didFinishEditingCustomerAtIndexPath:editingIndexPath];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
