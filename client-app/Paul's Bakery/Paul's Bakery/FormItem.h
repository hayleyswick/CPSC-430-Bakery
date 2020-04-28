//
//  FormItem.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FormItemSelection.h"

typedef enum {
    formItemTypeText = 0,
    formItemTypeSelection = 1
}formItemType;

@interface FormItem : NSObject

@property NSString *identifier;
@property NSString *value;
@property NSString *placeholder;
@property BOOL editable;
@property BOOL secure;
@property formItemType type;
@property NSMutableArray *selectionItems;

-(id)init;
-(id)initWithIdentifier:(NSString *)identifier withPlaceholder:(NSString *)placeholder withSecurity:(BOOL)secure allowEditing:(BOOL)editable;
-(void)textFieldDidChange:(UITextField *)textField;
-(FormItemSelection *)selectedItem;
-(void)addSelectionItem:(FormItemSelection *)i;

@end
