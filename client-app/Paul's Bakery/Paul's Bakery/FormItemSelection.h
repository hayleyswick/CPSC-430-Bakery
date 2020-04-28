//
//  FormItemSelection.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormItemSelection : NSObject

-(id)init;
-(id)initWithSelectionText:(NSString *)text selected:(BOOL)selected;
-(BOOL)isEqual:(FormItemSelection *)item;

@property NSString *selectionText;
@property BOOL selected;

@end
