//
//  EFTheme.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFTheme.h"

@implementation EFTheme

+ (void)applyTheme
{
  UIFont *navigationBarFont = [UIFont systemFontOfSize:12.0];
  [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: navigationBarFont}];
}

@end
