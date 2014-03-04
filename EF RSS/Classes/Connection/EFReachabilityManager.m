//
//  EFReachabilityManager.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFReachabilityManager.h"
#import "AFNetworkReachabilityManager.h"
#import "CWStatusBarNotification.h"

@implementation EFReachabilityManager

+ (instancetype)sharedInstance
{
  static dispatch_once_t once;
  static id sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

- (void)start
{
  [[AFNetworkReachabilityManager sharedManager] startMonitoring];
  
}

@end
