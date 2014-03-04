//
//  EFAppDelegate.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFAppDelegate.h"
#import "EFCoreDataManager.h"
#import "EFRSSDownloaderManager.h"
#import "EFReachabilityManager.h"

@implementation EFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //initializes core data
  [[EFCoreDataManager sharedManager] initializeCoreDataStack];
  
  //initializes reachability notifier
  
  
  //downloads the rss feed
  [[EFRSSDownloaderManager sharedManager] download];
  
  return YES;
}

@end
