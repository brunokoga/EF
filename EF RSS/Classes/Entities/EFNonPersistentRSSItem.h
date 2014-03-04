//
//  EFNonPersistentRSSItem.h
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 This class exists to create RSSItems but without messing with Core Data.
 This is useful when parsing the XML RSS feed and returning the entities, but
 Leaving for other process to take care of uniqueness or Core Data update rules,
 and then, makes the Parser classes more adept to SOR.
 */

@interface EFNonPersistentRSSItem : NSObject

@property (nonatomic, retain) NSString * guid;
@property (nonatomic, retain) NSString * itemDescription;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * media;
@property (nonatomic, retain) NSDate * publicationDate;
@property (nonatomic, retain) NSString * title;
//@property (nonatomic, retain) RSSFeed *feed;

@end
