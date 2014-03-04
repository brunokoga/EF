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

- (NSDictionary *)feedItemsFromXMLParser:(NSXMLParser *)XMLParser;

@end
