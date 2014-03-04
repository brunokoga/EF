//
//  EFCoreDataManager.h
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFCoreDataManager : NSObject
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedManager;
- (void)initializeCoreDataStack;

#pragma mark - RSS specific
- (id)newFeed;
- (id)newItem;

//if exists, returns it
//if doesn't exists, returns a new instance
- (id)newFeedWithFeedURL:(NSString *)feedURL;
- (id)newItemWithGUID:(NSString *)guid;
@end
