//
//  EFDetailViewController.h
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFBaseViewController.h"
#import "RSSItem.h"

@interface EFDetailViewController : EFBaseViewController
@property (strong, nonatomic) RSSItem *item;

@end
