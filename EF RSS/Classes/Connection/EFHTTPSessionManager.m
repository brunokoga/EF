//
//  EFHTTPSessionManager.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFHTTPSessionManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation EFHTTPSessionManager

+ (instancetype)sharedManager
{
  static dispatch_once_t once;
  static id sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
  });
  return sharedInstance;
}

- (void)feedWithSuccess:(void (^)(id responseObject))success
                failure:(void (^) (NSError *error))failure
{
  
}

@end
