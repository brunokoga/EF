//
//  EFSettings.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFSettings.h"

@implementation EFSettings

static NSString * const kSettingsFeedURLStringKey = @"kSettingsFeedURLStringKey";
static NSString * const kFeedDefaultURLString = @"http://feeds.bbci.co.uk/news/rss.xml";

+ (NSString *)feedURLString
{
  NSString *feedURLString;
  feedURLString = [[NSUserDefaults standardUserDefaults] stringForKey:kSettingsFeedURLStringKey];
  if ([feedURLString length] == 0) {
    feedURLString = kFeedDefaultURLString;
  }
  return feedURLString;
}

+ (void)setFeedURLString:(NSString *)feedURLString
{
  [[NSUserDefaults standardUserDefaults] setObject:feedURLString forKey:kSettingsFeedURLStringKey];
}

+ (NSString *)defaultFeedURLString
{
  return kFeedDefaultURLString;
}

@end
