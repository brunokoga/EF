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
#import "EFStatusBarNotifier.h"

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
  [self downloadWithCompletion:^(BOOL finished) {
    
  }];
}

- (void)downloadWithCompletion:(void (^)(BOOL finished))completion
{
  NSURL *url = [NSURL URLWithString:[EFSettings feedURLString]];
  EFHTTPSessionManager *sessionManager = [EFHTTPSessionManager sharedManager];
  sessionManager.baseURL = url;
  
  [sessionManager feedWithSuccess:^(id responseObject) {
    NSDictionary *feedItems = [[EFRSSParser new] feedItemsFromXMLParser:responseObject];
    [EFRSSPersister insertOrUpdateRSSItems:feedItems];
    [EFStatusBarNotifier displayContentDownloadedMessage];
    completion(YES);
  } failure:^(NSError *error) {
    [EFStatusBarNotifier displayConnectionErrorMessageWithError:error];
    completion(YES);
  }];
  
}
@end
