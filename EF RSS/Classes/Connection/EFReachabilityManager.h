//
//  EFReachabilityManager.h
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFReachabilityManager : NSObject
/*
 Not being used yet, since we're going to manually refresh
 */
+ (instancetype)sharedInstance;

- (void)start;
@end
