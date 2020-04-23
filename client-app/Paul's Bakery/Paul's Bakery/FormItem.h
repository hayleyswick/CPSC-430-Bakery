//
//  FormItem.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormItem : NSObject

@property NSString *identifier;
@property NSString *value;
@property NSString *placeholder;
@property BOOL editable;

-(id)init;
-(id)initWithIdentifier:(NSString *)identifier withPlaceholder:(NSString *)placeholder;
-(void)textFieldDidChange:(UITextField *)textField;


@end
