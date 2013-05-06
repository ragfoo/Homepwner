//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Ryan Gallagher on 5/6/13.
//  Copyright (c) 2013 Ryan Gallagher. All rights reserved.
//

#import "BNRImageStore.h"

@implementation BNRImageStore

+ (id)allocWithZone:(NSZone *)zone{
    return [self sharedStore];
}

+ (BNRImageStore *)sharedStore
{
    static BNRImageStore *sharedStore = nil;
    if (!sharedStore){
        sharedStore = [[super allocWithZone: NULL]init];
    }
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if(self){
        dictionary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)setImage:(UIImage *)i forKey:(NSString *)s
{
    [dictionary setObject:i forKey:s];
}

- (UIImage *)imageForKey:(NSString *)s{
    return [dictionary objectForKey:s];
}

-(void)deleteImageForKey:(NSString *)s{
    if(!s){
        return;
    }
    [dictionary removeObjectForKey:s];
}
@end
