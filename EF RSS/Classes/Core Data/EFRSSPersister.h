//
//  EFRSSPersister.h
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFRSSPersister : NSObject

+ (void)insertOrUpdateRSSItems:(NSDictionary *)items;

@end
