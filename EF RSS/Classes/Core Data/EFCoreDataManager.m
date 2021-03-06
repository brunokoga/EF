//
//  EFCoreDataManager.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFCoreDataManager.h"

@implementation EFCoreDataManager

+ (instancetype)sharedManager
{
  static dispatch_once_t once;
  static id sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}


- (void)initializeCoreDataStack
{
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EF_RSS"
                                            withExtension:@"momd"];
  NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
  
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_async(queue, ^{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryArray = [fileManager URLsForDirectory:NSDocumentDirectory
                                                  inDomains:NSUserDomainMask];
    NSURL *storeURL = [directoryArray lastObject];
    NSString *filename = @"rssFeedItems.sqlite";
    storeURL = [storeURL URLByAppendingPathComponent:filename];
    NSError *error;
    NSPersistentStore *store = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                        configuration:nil
                                                                                  URL:storeURL
                                                                              options:nil
                                                                                error:&error];
    if (!store)
    {
      NSLog(@"Error adding persistent store to coordinator %@\n%@",
            [error localizedDescription], [error userInfo]);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      [self contextInitialized];
    });
  });
  NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
  [self setManagedObjectContext:managedObjectContext];
}

- (void)contextInitialized
{
  
}


#pragma mark - RSS specific

- (id)newEntityForName:(NSString *)name
{
  //TODO: add NSAssert here
  id entity = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.managedObjectContext];
  return entity;
}

- (id)newFeed {
  return [self newEntityForName:@"RSSFeed"];
}

- (id)newItem {
  return [self newEntityForName:@"RSSItem"];
}

- (id)newFeedWithFeedURL:(NSString *)feedURL {
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"feedURL LIKE %@", feedURL];
  
  NSArray *result;
  
  NSFetchRequest *fetchRequest = [NSFetchRequest new];
  [fetchRequest setEntity:[NSEntityDescription entityForName:@"RSSFeed"
                                      inManagedObjectContext:self.managedObjectContext]];
  
  [fetchRequest setPredicate:predicate];
  
  
  NSError *error;
  
  result = [self.managedObjectContext executeFetchRequest:fetchRequest
                                                    error:&error];
  
  if ([result count] == 1) {
    return result[0];
  }
  return [self newFeed];

}

- (id)newItemWithGUID:(NSString *)guid {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid LIKE %@", guid];
  
  NSArray *result;
  
  NSFetchRequest *fetchRequest = [NSFetchRequest new];
  [fetchRequest setEntity:[NSEntityDescription entityForName:@"RSSItem"
                                      inManagedObjectContext:self.managedObjectContext]];
  
      [fetchRequest setPredicate:predicate];
  
  
  NSError *error;
  
  result = [self.managedObjectContext executeFetchRequest:fetchRequest
                                                    error:&error];
  
  if ([result count] == 1) {
    return result[0];
  }
  return [self newItem];
}

@end
