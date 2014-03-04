//
//  EFRSSParser.h
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFNonPersistentRSSItem.h"

@interface EFRSSParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *rssItems;
@property (nonatomic, strong) EFNonPersistentRSSItem *currentRSSObject;
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) NSMutableString *currentElementValue;

@property (nonatomic, copy) NSString *entryElementName;

- (NSArray *)feedItemsFromXMLParser:(NSXMLParser *)XMLParser;

@end
