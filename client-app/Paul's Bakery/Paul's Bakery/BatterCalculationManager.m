//
//  BatterCalculationManager.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "BatterCalculationManager.h"

@implementation BatterCalculationManager

//constants

//vanilla LBS
const double vanillaFullRound = 1.05;
const double vanillaFullSheet = 6.2;
const double vanillaCupcakePan = 2.0;
const double vanillaFullRecipe = 425.4;

//chocolate LBS
const double chocolateFullRound = 1.1;
const double chocolateFullSheet = 6.2;
const double chocolateCupcakePan = 2.0;
const double chocolateFullRecipe = 320.9;

//general
const double bigBowl = 240.0;
const double medBowl = 160.0;


-(id)init {
    self = [super init];
    
    return self;
}

+(BatterCalculationManager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static BatterCalculationManager *sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}
-(double)getBatterNeededForOrder:(Order *)o ofBatterType:(NSString *)batterType {
    double pounds = 0;
    if ([batterType isEqualToString:@BatterTypeVanilla]) {
        pounds += [self getNumberOfRoundsForOrder:o ofBatterType:batterType] * vanillaFullRound;
        pounds += [self getNumberOfSheetsForOrder:o ofBatterType:batterType] * vanillaFullSheet;
    } else if ([batterType isEqualToString:@BatterTypeChocolate]) {
        pounds += [self getNumberOfRoundsForOrder:o ofBatterType:batterType] * chocolateFullRound;
        pounds += [self getNumberOfSheetsForOrder:o ofBatterType:batterType] * chocolateFullSheet;
    }
    
    return pounds;
}
-(int)getNumberOfRoundsForOrder:(Order *)o ofBatterType:(NSString *)batterType {
    int rounds = 0;
    for (OrderItem *i in o.items) {
        if ([batterType isEqualToString:i.batterType]) {
            if ([i.cakeType isEqualToString:@CakeTypeFullRound]) {
                rounds++;
            }
        }
    }
    return rounds;
}
-(int)getNumberOfSheetsForOrder:(Order *)o ofBatterType:(NSString *)batterType {
    double neededSheets = 0.0;
    int quarterSheets = 0;
    int halfSheets = 0;
    int fullSheets = 0;
    for (OrderItem *i in o.items) {
        if ([batterType isEqualToString:i.batterType]) {
            if ([i.cakeType isEqualToString:@CakeTypeQuarterSheet]) {
                quarterSheets += i.quantity;
            } else if ([i.cakeType isEqualToString:@CakeTypeHalfSheet]) {
                halfSheets += i.quantity;
            } else if ([i.cakeType isEqualToString:@CakeTypeFullSheet]) {
                fullSheets += i.quantity;
            }
        }
    }
    neededSheets = (quarterSheets * 0.25) + (halfSheets * 0.5) + fullSheets;
    return (int)ceil(neededSheets);
}
-(double)getVanillaBatterNeededForOrder:(Order *)o {
    return [self getBatterNeededForOrder:o ofBatterType:@BatterTypeVanilla];
}
-(double)getChocolateBatterNeededForOrder:(Order *)o {
    return [self getBatterNeededForOrder:o ofBatterType:@BatterTypeChocolate];
}
-(int)getNumberOfVanillaSheetsNeededForOrder:(Order *)o {
    return [self getNumberOfSheetsForOrder:o ofBatterType:@BatterTypeVanilla];
}
-(int)getNumberOfVanillaRoundsNeededForOrder:(Order *)o {
    return [self getNumberOfRoundsForOrder:o ofBatterType:@BatterTypeVanilla];
}
-(int)getNumberOfChocolateSheetsNeededForOrder:(Order *)o {
    return [self getNumberOfSheetsForOrder:o ofBatterType:@BatterTypeChocolate];
}
-(int)getNumberOfChocolateRoundsNeededForOrder:(Order *)o {
    return [self getNumberOfRoundsForOrder:o ofBatterType:@BatterTypeChocolate];
}

@end
