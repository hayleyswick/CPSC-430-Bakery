//
//  SelectionItem.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/18/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectionItem : NSObject {
    BOOL isSelected;
}

@property (nonatomic, strong) UIImage *selectionItemImage;
@property (nonatomic, strong) NSString *selectionItemText;
@property (nonatomic, strong) NSString *referenceString;

-(id)init;
-(id)initWithImage:(UIImage *)img forText:(NSString *)text withReferenceString:(NSString *)ref;
-(void)setIsSelected:(BOOL)selected;
-(BOOL)isSelected;

@end
