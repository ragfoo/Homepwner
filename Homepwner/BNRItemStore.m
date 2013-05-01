//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Ryan Gallagher on 4/29/13.
//  Copyright (c) 2013 Ryan Gallagher. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemStore

+ (BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil]init];
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}


- (id)init
{
    self = [super init];
    if (self){
        allItems = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)removeItem:(BNRItem *)p
{
    [allItems removeObjectIdenticalTo:p];
}

- (void)moveItemsAtIndex:(int)from toIndex:(int)to
{
    if(from == to){
        return;
    }
    
    BNRItem *p = [allItems objectAtIndex:from];
    
    [allItems removeObjectAtIndex:from];
    [allItems insertObject:p atIndex:to];
}




- (NSArray *)allItems
{
    return allItems;
}

- (BNRItem *)createItem
{
    BNRItem *p = [BNRItem randomItem];
    [allItems addObject:p];
    
    return p;
}
@end
