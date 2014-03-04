//
//  EFSettings.h
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFSettings : NSObject


//TODO: write unit tests

/*
 Returns the stored feed url string.
 If there isn't a stored feed url string, will return the default one.
 */

+ (NSString *)feedURLString;

/*
 Stores the feed url string
 */
+ (void)setFeedURLString:(NSString *)feedURLString;

+ (NSString *)defaultFeedURLString;
@end
