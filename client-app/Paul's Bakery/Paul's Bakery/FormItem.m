//
//  FormItem.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "FormItem.h"

@implementation FormItem

-(id)init {
    self = [super init];
    self.value=@"";
    self.editable = YES;
    self.secure = NO;
    self.type = formItemTypeText;
    self.selectionItems = [[NSMutableArray alloc] init];
    return self;
}

-(id)initWithIdentifier:(NSString *)identifier withPlaceholder:(NSString *)placeholder withSecurity:(BOOL)secure allowEditing:(BOOL)editable {
    self = [self init];
    self.identifier = identifier;
    self.placeholder = placeholder;
    self.secure = secure;
    self.editable = editable;
    return self;
}

-(void)textFieldDidChange:(UITextField *)textField {
    self.value = textField.text;
}
-(FormItemSelection *)selectedItem {
    for (FormItemSelection *i in self.selectionItems) {
        if (i.selected) {
            return i;
        }
    }
    return [self.selectionItems objectAtIndex:0];
}
-(void)addSelectionItem:(FormItemSelection *)i {
    [self.selectionItems addObject:i];
}
@end
