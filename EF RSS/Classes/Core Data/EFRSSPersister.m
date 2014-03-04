//
//  EFRSSPersister.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFRSSPersister.h"
#import "EFCoreDataManager.h"
#import "RSSItem.h"
#import "RSSFeed.h"
#import "EFNonPersistentRSSItem.h"
#import "EFSettings.h"

@implementation EFRSSPersister

+ (void)insertOrUpdateRSSItems:(NSDictionary *)itemsDictionary
{
  
  NSString *feedURL = [EFSettings feedURLString];
  NSString *key = [itemsDictionary allKeys][0];
  NSArray *items = [itemsDictionary objectForKey:key];
  EFCoreDataManager *manager = [EFCoreDataManager sharedManager];

  RSSFeed *managedFeed = [manager newFeedWithFeedURL:feedURL];
  managedFeed.title = key;
  managedFeed.feedURL = feedURL; //if its new
  
  for (EFNonPersistentRSSItem *item in items) {
    RSSItem *managedItem = [manager newItemWithGUID:item.guid];
    managedItem.title = item.title;
    managedItem.itemDescription = item.itemDescription;
    managedItem.guid = item.guid;
    managedItem.media = item.media;
    managedItem.link = item.link;
    managedItem.publicationDate = item.publicationDate;
    
    [managedFeed addItemsObject:managedItem];
  }
  NSError *error;
  //TODO: treat error accordinlgy
  [manager.managedObjectContext save:&error];
}

@end
