//
//  RSSItem.h
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RSSFeed;

@interface RSSItem : NSManagedObject

@property (nonatomic, retain) NSString * guid;
@property (nonatomic, retain) NSString * itemDescription;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * media;
@property (nonatomic, retain) NSDate * publicationDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) RSSFeed *feed;

@end
