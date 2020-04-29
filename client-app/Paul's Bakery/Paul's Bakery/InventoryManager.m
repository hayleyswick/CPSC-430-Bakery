//
//  InventoryManager.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/27/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "InventoryManager.h"

@implementation InventoryManager

-(id)init {
    self = [super init];
    inventories = [[NSMutableArray alloc] init];
    return self;
}

+(InventoryManager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static InventoryManager *sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

-(void)connection:(RESTQueryController *)conn didFinishSuccessfullyWithData:(NSDictionary *)data {
    if (conn == connectionGetInventory) {
        NSArray *inventoryData = [data objectForKey:@kResponseDataItem];
        for (NSDictionary *d in inventoryData) {
            [inventories addObject:[[Inventory alloc] initWithDict:d]];
        }
        [self.delegate didUpdateInventoryData];
    } else if (conn == connectionSaveInventory) {
        [self.delegate inventoryDataWasUpdated];
    }
}

-(void)fetchCurrentInventoryData {
    NSDictionary *data = @{@"session_id":[[PreferencesHandler sharedInstance] currentSessionID]};
    connectionGetInventory = [[RESTQueryController alloc] init];
    [connectionGetInventory sendGETRequestToEndpoint:@"/api/get_inventory" withData:data delegate:self];
}
-(void)saveInventoryEditsForInventory:(Inventory *)i {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:[i dictRepresentation]];
    [data setObject:[[PreferencesHandler sharedInstance] currentSessionID] forKey:@"session_id"];
    connectionSaveInventory = [[RESTQueryController alloc] init];
    [connectionSaveInventory sendPOSTRequestToEndpoint:@"/api/update_inventory_count" withData:data delegate:self];
}
-(void)updateInventory:(Inventory *)i {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:[i dictRepresentation]];
    [data setObject:[[PreferencesHandler sharedInstance] currentSessionID] forKey:@"session_id"];
    connectionUpdateInventory = [[RESTQueryController alloc] init];
    [connectionUpdateInventory sendPOSTRequestToEndpoint:@"/api/update_inventory" withData:data delegate:self];
}
-(void)discardInventoryEditsForInventory:(Inventory *)i {
    [inventories removeObject:i];
}
-(Inventory *)getInventoryWithID:(NSString *)identifier {
    for (Inventory *i in inventories) {
        if ([i.identifier isEqualToString:identifier]) {
            return i;
        }
    }
    Inventory *new = [[Inventory alloc] init];
    new.identifier = identifier;
    [inventories addObject:new];
    return new;
}

@end
