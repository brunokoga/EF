//
//  RSSFeed.h
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RSSFeed : NSManagedObject

@property (nonatomic, retain) NSString * copyright;
@property (nonatomic, retain) NSString * feedDescription;
@property (nonatomic, retain) NSString * feedURL;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSDate * lastBuildDate;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *items;
@end

@interface RSSFeed (CoreDataGeneratedAccessors)

- (void)addItemsObject:(NSManagedObject *)value;
- (void)removeItemsObject:(NSManagedObject *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
