//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Ryan Gallagher on 4/29/13.
//  Copyright (c) 2013 Ryan Gallagher. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject
{
    NSMutableArray *allItems;
}

+ (BNRItemStore *)sharedStore;
- (void)removeItem:(BNRItem *)p;
- (void)moveItemsAtIndex:(int)from toIndex:(int)to;
- (NSArray *)allItems;
- (BNRItem *)createItem;

@end
