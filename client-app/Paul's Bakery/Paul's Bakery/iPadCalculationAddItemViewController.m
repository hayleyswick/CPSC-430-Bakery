//
//  iPadCalculationAddItemViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadCalculationAddItemViewController.h"

@interface iPadCalculationAddItemViewController ()

@end

@implementation iPadCalculationAddItemViewController

static NSString *CellIdentifier = @"SelectionViewCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFormSheet;
        currentMode = selectionModeAdd;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.quantityView.layer setCornerRadius:10];
    [self initSelections];
    [self.cakeTypeSelectionView registerNib:[UINib nibWithNibName:@"ItemSelectionView" bundle:nil] forCellWithReuseIdentifier:@"SelectionViewCell"];
    [self.cakeTypeSelectionView setBackgroundColor:[UIColor clearColor]];
    self.cakeTypeSelectionView.delegate = self;
    self.cakeTypeSelectionView.dataSource = self;
    
    [self.batterTypeSelectionView registerNib:[UINib nibWithNibName:@"ItemSelectionView" bundle:nil] forCellWithReuseIdentifier:@"SelectionViewCell"];
    [self.batterTypeSelectionView setBackgroundColor:[UIColor clearColor]];
    self.batterTypeSelectionView.delegate = self;
    self.batterTypeSelectionView.dataSource = self;
    
    [self.quantityControl setMinimumValue:1.0];
    [self updateUIForCurrentMode];
}
-(void)initSelections {
    if (!cakeTypeSelections) {
        cakeTypeSelections = [[NSMutableArray alloc] init];
    }
    [cakeTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"quarter.png"] forText:@"1/4 Sheet" withReferenceString:@CakeTypeQuarterSheet]];
    [cakeTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"half.png"] forText:@"1/2 Sheet" withReferenceString:@CakeTypeHalfSheet]];
    [cakeTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"full.png"] forText:@"Full Sheet" withReferenceString:@CakeTypeFullSheet]];
    [cakeTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"round.png"] forText:@"Full Round" withReferenceString:@CakeTypeFullRound]];
    if (!batterTypeSelections) {
        batterTypeSelections = [[NSMutableArray alloc] init];
    }
    [batterTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"cake.png"] forText:@"Vanilla Batter" withReferenceString:@BatterTypeVanilla]];
    [batterTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"chocolate.png"] forText:@"Chocolate Batter" withReferenceString:@BatterTypeChocolate]];
}
-(void)updateUIForCurrentMode {
    switch (currentMode) {
        case selectionModeAdd:
            [self.navItem setTitle:@"Add Item"];
            [self.navItem.rightBarButtonItem setTitle:@"Add"];
            break;
        case selectionModeEdit:
            [self.navItem setTitle:@"Edit Item"];
            [self.navItem.rightBarButtonItem setTitle:@"Save"];
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setSelectionMode:(selectionMode)mode {
    currentMode = mode;
    [self updateUIForCurrentMode];
}
-(void)setEditingOrderItem:(OrderItem *)item {
    editingItem = item;
    for (SelectionItem *i in cakeTypeSelections) {
        if ([[i referenceString] isEqualToString:[editingItem cakeType]]) {
            [i setIsSelected:YES];
        } else {
            [i setIsSelected:NO];
        }
    }
    for (SelectionItem *i in batterTypeSelections) {
        if ([[i referenceString] isEqualToString:[editingItem batterType]]) {
            [i setIsSelected:YES];
        } else {
            [i setIsSelected:NO];
        }
    }
    [self.quantityControl setValue:[editingItem quantity]];
    [self quantityValueChanged:self];
    [self.cakeTypeSelectionView reloadData];
    [self.batterTypeSelectionView reloadData];
}
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.cakeTypeSelectionView) {
        return [cakeTypeSelections count];
    } else if (collectionView == self.batterTypeSelectionView) {
        return [batterTypeSelections count];
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemSelectionView *cell = (ItemSelectionView *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (collectionView == self.cakeTypeSelectionView) {
        [cell setImage:[[cakeTypeSelections objectAtIndex:indexPath.row] selectionItemImage]];
        [cell setText:[[cakeTypeSelections objectAtIndex:indexPath.row] selectionItemText]];
        if ([[cakeTypeSelections objectAtIndex:indexPath.row] isSelected]) {
            [cell setSelectionActive];
        } else {
            [cell setSelectionInactive];
        }
    } else if (collectionView == self.batterTypeSelectionView) {
        [cell setImage:[[batterTypeSelections objectAtIndex:indexPath.row] selectionItemImage]];
        [cell setText:[[batterTypeSelections objectAtIndex:indexPath.row] selectionItemText]];
        if ([[batterTypeSelections objectAtIndex:indexPath.row] isSelected]) {
            [cell setSelectionActive];
        } else {
            [cell setSelectionInactive];
        }
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.cakeTypeSelectionView) {
        for (int i=0; i<cakeTypeSelections.count; i++) {
            if (i == indexPath.row) {
                [[cakeTypeSelections objectAtIndex:i] setIsSelected:YES];
            } else {
                [[cakeTypeSelections objectAtIndex:i] setIsSelected:NO];
            }
        }
        [self.cakeTypeSelectionView reloadData];
    } else if (collectionView == self.batterTypeSelectionView) {
        for (int i=0; i<batterTypeSelections.count; i++) {
            if (i == indexPath.row) {
                [[batterTypeSelections objectAtIndex:i] setIsSelected:YES];
            } else {
                [[batterTypeSelections objectAtIndex:i] setIsSelected:NO];
            }
        }
        [self.batterTypeSelectionView reloadData];
    }
}


- (IBAction)quantityValueChanged:(id)sender {
    [self.quantityLabel setText:[NSString stringWithFormat:@"%d", (int)[self.quantityControl value]]];
}

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addItemAndClose:(id)sender {
    OrderItem *item;
    if (currentMode == selectionModeAdd) {
        item = [[OrderItem alloc] init];
    } else if (currentMode == selectionModeEdit) {
        item = editingItem;
    }
    BOOL batterSelected = NO;
    BOOL cakeSelected = NO;
    for (SelectionItem *i in cakeTypeSelections) {
        if ([i isSelected]) {
            item.cakeType = i.referenceString;
            item.cakeTypeText = i.selectionItemText;
            item.cakeTypeImage = i.selectionItemImage;
            cakeSelected = YES;
            break;
        }
    }
    for (SelectionItem *i in batterTypeSelections) {
        if ([i isSelected]) {
            item.batterType = i.referenceString;
            item.batterTypeText = i.selectionItemText;
            item.batterTypeImage = i.selectionItemImage;
            batterSelected = YES;
            break;
        }
    }
    
    if (batterSelected && cakeSelected) {
        item.quantity = (int)[self.quantityControl value];
        [self.delegate didFinishEditingWithItem:item];
        [self closeView:self];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Options Not Selected" message:@"Please select all options before adding an item." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}
-(void)clear {
    for (SelectionItem *i in cakeTypeSelections) {
        [i setIsSelected:NO];
    }
    for (SelectionItem *i in batterTypeSelections) {
        [i setIsSelected:NO];
    }
    [self.quantityControl setValue:1.0];
    [self quantityValueChanged:self];
    [self.cakeTypeSelectionView reloadData];
    [self.batterTypeSelectionView reloadData];
}

@end
