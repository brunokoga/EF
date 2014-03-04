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
#import "EFTheme.h"

@implementation EFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //applies layout and theme
  [EFTheme applyTheme];
  
  
  //initializes core data
  [[EFCoreDataManager sharedManager] initializeCoreDataStack];
  
  //downloads the rss feed
  [[EFRSSDownloaderManager sharedManager] download];
  
  return YES;
}

@end
