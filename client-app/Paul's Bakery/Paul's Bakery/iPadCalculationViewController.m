//
//  iPadCalculationViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/16/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadCalculationViewController.h"

@interface iPadCalculationViewController ()

@end

@implementation iPadCalculationViewController

static NSString *CellIdentifier = @"SelectionViewCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Calculate" image:[UIImage imageNamed:@"calculator.png"] tag:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.quantityView.layer setCornerRadius:10];
    [self initSelections];
    self.navigationItem.title = @"Paul's Bakery Batter Calculator";
    [self.cakeTypeSelectionView registerNib:[UINib nibWithNibName:@"ItemSelectionView" bundle:nil] forCellWithReuseIdentifier:@"SelectionViewCell"];
    [self.cakeTypeSelectionView setBackgroundColor:[UIColor clearColor]];
    self.cakeTypeSelectionView.delegate = self;
    self.cakeTypeSelectionView.dataSource = self;
    
    [self.batterTypeSelectionView registerNib:[UINib nibWithNibName:@"ItemSelectionView" bundle:nil] forCellWithReuseIdentifier:@"SelectionViewCell"];
    [self.batterTypeSelectionView setBackgroundColor:[UIColor clearColor]];
    self.batterTypeSelectionView.delegate = self;
    self.batterTypeSelectionView.dataSource = self;
}
-(void)initSelections {
    if (!cakeTypeSelections) {
        cakeTypeSelections = [[NSMutableArray alloc] init];
    }
    [cakeTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"quarter.png"] forText:@"1/4 Sheet"]];
    [cakeTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"half.png"] forText:@"1/2 Sheet"]];
    [cakeTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"full.png"] forText:@"Full Sheet"]];
    [cakeTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"round.png"] forText:@"Full Round"]];
    if (!batterTypeSelections) {
        batterTypeSelections = [[NSMutableArray alloc] init];
    }
    [batterTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"cake.png"] forText:@"Vanilla Cake"]];
    [batterTypeSelections addObject:[[SelectionItem alloc] initWithImage:[UIImage imageNamed:@"chocolate.png"] forText:@"Chocolate Cake"]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat totalCellWidth = 119 * cakeTypeSelections.count;
    CGFloat totalSpacingWidth = 10 * (((float)cakeTypeSelections.count - 1) < 0 ? 0 :cakeTypeSelections.count - 1);
    CGFloat leftInset = (self.cakeTypeSelectionView.bounds.size.width - (totalCellWidth + totalSpacingWidth)) / 2;
    CGFloat rightInset = leftInset;
    UIEdgeInsets sectionInset = UIEdgeInsetsMake(0, leftInset, 0, rightInset);
    return sectionInset;
}*/

@end
