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
#import "EFNonPersistentRSSItem.h"

@implementation EFRSSPersister

+ (void)insertOrUpdateRSSItems:(NSArray *)items
{
  EFCoreDataManager *manager = [EFCoreDataManager sharedManager];
  for (EFNonPersistentRSSItem *item in items) {
    RSSItem *managedItem = [manager newItemWithGUID:item.guid];
    managedItem.title = item.title;
    managedItem.itemDescription = item.itemDescription;
    managedItem.guid = item.guid;
    managedItem.media = item.media;
    managedItem.link = item.link;
  }
  NSError *error;
  //TODO: treat error accordinlgy
  [manager.managedObjectContext save:&error];
}

@end
