//
//  EFRSSDownloaderManager.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFRSSDownloaderManager.h"
#import "EFSettings.h"
#import "EFHTTPSessionManager.h"
#import "EFRSSParser.h"
#import "EFRSSPersister.h"

@implementation EFRSSDownloaderManager

+ (instancetype)sharedManager
{
  static dispatch_once_t once;
  static id sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

- (void)download {
  
  NSURL *url = [NSURL URLWithString:[EFSettings feedURLString]];
  EFHTTPSessionManager *sessionManager = [EFHTTPSessionManager sharedManager];
  sessionManager.baseURL = url;
  
  [sessionManager feedWithSuccess:^(id responseObject) {
            NSArray *feedItems = [[EFRSSParser new] feedItemsFromXMLParser:responseObject];
    [EFRSSPersister insertOrUpdateRSSItems:feedItems];
    
  } failure:^(NSError *error) {
    //TODO: display Error;
  }];
}
@end
