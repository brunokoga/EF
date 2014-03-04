//
//  EFHTTPSessionManager.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFHTTPSessionManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation EFHTTPSessionManager

+ (instancetype)sharedManager
{
  static dispatch_once_t once;
  static EFHTTPSessionManager *sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
    sharedInstance.responseSerializer = [AFXMLParserResponseSerializer serializer];
    sharedInstance.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
  });
  return sharedInstance;
}

- (void)feedWithSuccess:(void (^)(id responseObject))success
                failure:(void (^) (NSError *error))failure
{
  [self GET:@""
 parameters:nil
    success:^(NSURLSessionDataTask *task, id responseObject) {
      
      //TODO: we're receiving a NSXMLParser here
      
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      failure(error);
    }];
}

@end
