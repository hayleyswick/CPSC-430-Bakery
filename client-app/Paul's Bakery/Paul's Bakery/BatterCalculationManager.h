//
//  BatterCalculationManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#include <math.h>
#import "Manager.h"
#import "Order.h"

@interface BatterCalculationManager : Manager

-(id)init;
+(BatterCalculationManager *)sharedInstance;
-(double)getVanillaBatterNeededForOrder:(Order *)o;
-(double)getChocolateBatterNeededForOrder:(Order *)o;
-(int)getNumberOfVanillaSheetsNeededForOrder:(Order *)o;
-(int)getNumberOfVanillaRoundsNeededForOrder:(Order *)o;
-(int)getNumberOfChocolateSheetsNeededForOrder:(Order *)o;
-(int)getNumberOfChocolateRoundsNeededForOrder:(Order *)o;


@end
