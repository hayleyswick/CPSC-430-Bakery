//
//  iPadChangeUsernameFormViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/26/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadChangeUsernameFormViewController.h"

@interface iPadChangeUsernameFormViewController ()

@end

@implementation iPadChangeUsernameFormViewController

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
    FormSection *usernameSection = [[FormSection alloc] init];
    [usernameSection addItem:[[FormItem alloc] initWithIdentifier:@kUsername withPlaceholder:@"New Username" withSecurity:NO allowEditing:YES]];
    [form addSection:usernameSection];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Change Username"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Change" style:UIBarButtonItemStyleDone target:self action:@selector(changeUsername)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeUsername {
    [UserManager sharedInstance].delegate = self;
    [[UserManager sharedInstance] setCurrentUserUsername:[form getItemWithIdentifier:@kUsername].value];
}
-(void)usernameWasUpdatedForUser:(User *)user {
    [self.delegate didFinishChangingUsername];
    [self closeView];
}
@end
