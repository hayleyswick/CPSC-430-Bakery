//
//  ModalFormSelectionEditor.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "ModalFormSelectionEditor.h"

@interface ModalFormSelectionEditor ()

@end

@implementation ModalFormSelectionEditor

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:219.0/255.0 alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSelectionItems:(NSArray *)items {
    selectionItems = items;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return selectionItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SelectionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    FormItemSelection *sel = [selectionItems objectAtIndex:indexPath.row];
    
    if (sel.selected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selected = sel.selected;
    cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
    cell.textLabel.text = sel.selectionText;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (int i=0; i<selectionItems.count; i++) {
        FormItemSelection *sel = [selectionItems objectAtIndex:i];
        if (i != indexPath.row) {
            sel.selected = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            sel.selected = YES;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    [self.delegate didChangeSelectionOfItems:selectionItems forIndexPath:self.editingIndexPath];
    [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
