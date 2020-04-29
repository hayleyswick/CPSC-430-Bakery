//
//  InventoryManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/27/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "Manager.h"
#import "Inventory.h"

#define kInventoryIDBatter "batter"
#define kInventoryItemVanillaBatter "vanilla"
#define kInventoryItemChocolateBatter "chocolate"

@protocol InventoryManagerDelegate <NSObject>
@optional
-(void)didUpdateInventoryData;
-(void)inventoryDataWasUpdated;
@end

@interface InventoryManager : Manager {
    RESTQueryController *connectionGetInventory;
    RESTQueryController *connectionSaveInventory;
    RESTQueryController *connectionUpdateInventory;
    NSMutableArray *inventories;
}

@property (nonatomic, strong) id <InventoryManagerDelegate> delegate;

-(id)init;
+(InventoryManager *)sharedInstance;
-(void)fetchCurrentInventoryData;
-(void)saveInventoryEditsForInventory:(Inventory *)i;
-(void)discardInventoryEditsForInventory:(Inventory *)i;
-(Inventory *)getInventoryWithID:(NSString *)identifier;
-(void)updateInventory:(Inventory *)i;

@end
