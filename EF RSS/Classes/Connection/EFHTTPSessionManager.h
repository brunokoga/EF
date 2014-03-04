//
//  EFHTTPSessionManager.h
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface EFHTTPSessionManager : AFHTTPSessionManager
@property (strong, nonatomic) NSURL *baseURL;

+ (instancetype)sharedManager;

- (void)feedWithSuccess:(void (^)(id responseObject))success
                failure:(void (^) (NSError *error))failure;
@end
