//
//  EFStatusBarNotifier.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFStatusBarNotifier.h"
#import "CWStatusBarNotification.h"

@implementation EFStatusBarNotifier

+ (void)displayConnectionErrorMessageWithError:(NSError *)error
{
  CWStatusBarNotification *notification = [[CWStatusBarNotification alloc] init];
  notification.notificationLabelBackgroundColor = [UIColor redColor];
  [notification displayNotificationWithMessage:error.localizedDescription forDuration:3.0];
}

+ (void)displayContentDownloadedMessage
{
  NSString *message = NSLocalizedString(@"Content downloaded 👍",@"");
  CWStatusBarNotification *notification = [[CWStatusBarNotification alloc] init];
  notification.notificationLabelBackgroundColor = [UIColor colorWithRed:12.0/255.0
                                                                  green:160.0/255.0
                                                                   blue:20.0/255.0
                                                                  alpha:1.0];
  [notification displayNotificationWithMessage:message forDuration:3.0];
}
@end
