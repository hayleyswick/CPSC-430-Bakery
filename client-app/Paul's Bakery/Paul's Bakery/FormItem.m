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
    self.editable = YES;
    self.secure = NO;
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

@end
