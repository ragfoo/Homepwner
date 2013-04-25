//
//  BNRItem.h
//  Homepwner
//
//  Created by Computerlab on 4/24/13.
//  Copyright (c) 2013 Ryan Gallagher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{
    NSString *itemName;
    NSString *serialNumber;
    int valueInDollars;
    NSDate *dateCreated;
}
@end
