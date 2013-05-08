//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Ryan Gallagher on 5/6/13.
//  Copyright (c) 2013 Ryan Gallagher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}

+ (BNRImageStore *)sharedStore;

- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *)imageForKey:(NSString *)s;
- (void)deleteImageForKey:(NSString *)s;
- (NSString *)imagePathForKey:(NSString *)key;
@end
