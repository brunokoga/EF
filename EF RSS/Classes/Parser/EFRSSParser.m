//
//  EFRSSParser.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFRSSParser.h"
#import "EFCoreDataManager.h"

@implementation EFRSSParser

- (NSArray *)feedItemsFromXMLParser:(NSXMLParser *)XMLParser
{
    self.rssItems = [NSMutableArray array];
    if ([XMLParser isKindOfClass:[NSXMLParser class]])
    {
        XMLParser.delegate = self;
        [XMLParser parse];
    }
    return [self.rssItems copy];
}


- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    [self.currentElementValue appendString:string];
}

#pragma mark - Specific

static NSString *kEFRSSXMLParserTitle = @"title";
static NSString *kEFRSSXMLParserSummary = @"description";
static NSString *kEFRSSXMLParserLink = @"link";

- (id)init
{
  self = [super init];
  if (self)
  {
    self.entryElementName = @"item";
  }
  return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
  if ([elementName isEqualToString:self.entryElementName])
  {
    self.currentRSSObject = [[EFCoreDataManager sharedManager] newItem];
  }
  else if ([elementName isEqualToString:kEFRSSXMLParserTitle])
  {
    self.currentElement = kEFRSSXMLParserTitle;
    self.currentElementValue = [NSMutableString new];
  }
  else if ([elementName isEqualToString:kEFRSSXMLParserSummary])
  {
    self.currentElement = kEFRSSXMLParserSummary;
    self.currentElementValue = [NSMutableString new];
  }
  else if ([elementName isEqualToString:kEFRSSXMLParserLink])
  {
    self.currentRSSObject.link = nil;
  }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
  if ([elementName isEqualToString:self.entryElementName])
  {
    if (self.currentRSSObject)
      [self.rssItems addObject:self.currentRSSObject];
    
    self.currentRSSObject = nil;
  }
  else if ([elementName isEqualToString:kEFRSSXMLParserTitle])
  {
    self.currentRSSObject.title = [self.currentElementValue copy];
  }
  else if ([elementName isEqualToString:kEFRSSXMLParserSummary])
  {
    self.currentRSSObject.itemDescription = [self.currentElementValue copy];
  }
}

@end
