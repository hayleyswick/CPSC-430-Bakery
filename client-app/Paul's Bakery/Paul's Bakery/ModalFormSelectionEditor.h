//
//  ModalFormSelectionEditor.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormItemSelection.h"

@protocol FormSelectionDelegate <NSObject>
@optional
-(void)didChangeSelectionOfItems:(NSArray *)items forIndexPath:(NSIndexPath *)path;
@end

@interface ModalFormSelectionEditor : UITableViewController {
    NSArray *selectionItems;
}

@property (nonatomic, strong) id <FormSelectionDelegate> delegate;

@property NSIndexPath *editingIndexPath;

-(void)setSelectionItems:(NSArray *)items;

@end
