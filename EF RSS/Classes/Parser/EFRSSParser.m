//
//  EFRSSParser.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFRSSParser.h"
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
static NSString *kEFRSSXMLParserGUID = @"guid";
static NSString *kEFRSSXMLParserImage = @"media:thumbnail";
static NSString *kEFRSSXMLParserPubDate = @"pubDate";


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
  //TODO: refactor this to be something smarter :)
  if ([elementName isEqualToString:self.entryElementName])
  {
    self.currentRSSObject = [EFNonPersistentRSSItem new];
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
    self.currentElement = kEFRSSXMLParserLink;
    self.currentElementValue = [NSMutableString new];
  }
  else if ([elementName isEqualToString:kEFRSSXMLParserGUID])
  {
    self.currentElement = kEFRSSXMLParserGUID;
    self.currentElementValue = [NSMutableString new];
  }
  else if ([elementName isEqualToString:kEFRSSXMLParserImage])
  {
    self.currentElement = kEFRSSXMLParserImage;
    self.currentElementValue = [[NSMutableString alloc] initWithString:[attributeDict objectForKey:@"url"]];
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
  else if ([elementName isEqualToString:kEFRSSXMLParserLink])
  {
    self.currentRSSObject.link = [self.currentElementValue copy];
  }
  else if ([elementName isEqualToString:kEFRSSXMLParserGUID])
  {
    self.currentRSSObject.guid = [self.currentElementValue copy];
  } else if ([elementName isEqualToString:kEFRSSXMLParserImage])
  {
    self.currentRSSObject.media = [self.currentElementValue copy];
  }
}

@end
