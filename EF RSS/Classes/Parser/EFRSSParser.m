//
//  EFRSSParser.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFRSSParser.h"

@interface EFRSSParser ()


@property (nonatomic, strong) NSMutableArray *rssItems;
@property (nonatomic, strong) EFNonPersistentRSSItem *currentRSSObject;
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) NSMutableString *currentElementValue;
@property (nonatomic, strong) NSString *channelName;
@property (nonatomic, copy) NSString *entryElementName;
@property (nonatomic, copy) NSString *parentElementName;

@property (nonatomic) BOOL isParsingParent;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end
@implementation EFRSSParser


- (NSDateFormatter *)dateFormatter {
  if (_dateFormatter) return _dateFormatter;
  
  NSDateFormatter *dateFormatter = [NSDateFormatter new];
  
  // Tue, 04 Mar 2014 13:25:57 GMT
  
  NSLocale *locale = [[NSLocale alloc]
                       initWithLocaleIdentifier:@"en_US_POSIX"];
  [dateFormatter setLocale:locale];
  [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
  _dateFormatter = dateFormatter;
  return _dateFormatter;
}
- (NSDictionary *)feedItemsFromXMLParser:(NSXMLParser *)XMLParser
{
    self.rssItems = [NSMutableArray array];
    if ([XMLParser isKindOfClass:[NSXMLParser class]])
    {
        XMLParser.delegate = self;
        [XMLParser parse];
    }
  NSArray *rssCopy = [self.rssItems copy];
  return @{self.channelName: rssCopy};
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
    self.parentElementName = @"channel";
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
  if ([elementName isEqualToString:self.parentElementName])
  {
    self.isParsingParent = YES;
  }
  
  if ([elementName isEqualToString:self.entryElementName])
  {
    self.currentRSSObject = [EFNonPersistentRSSItem new];
    self.isParsingParent = NO;
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
  else if ([elementName isEqualToString:kEFRSSXMLParserPubDate])
  {
    self.currentElement = kEFRSSXMLParserPubDate;
    self.currentElementValue = [NSMutableString new];
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
    if (self.isParsingParent) {
      self.channelName = [self.currentElementValue copy];
    } else {
      self.currentRSSObject.title = [self.currentElementValue copy];
    }
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
  } else if ([elementName isEqualToString:kEFRSSXMLParserPubDate])
  { // Tue, 04 Mar 2014 13:25:57 GMT
    NSDate *date = [self.dateFormatter dateFromString:self.currentElementValue];
    self.currentRSSObject.publicationDate = date;
  }
}

@end
