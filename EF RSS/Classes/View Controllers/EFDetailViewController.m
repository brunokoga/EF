//
//  EFDetailViewController.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFDetailViewController.h"

@interface EFDetailViewController () <UIActionSheetDelegate>

@end

@implementation EFDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)actionButtonTouched:(id)sender {
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Open with...", @"")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:nil otherButtonTitles:
                                NSLocalizedString(@"Safari",@""),
                                NSLocalizedString(@"More options", @""),
                                nil];
  [actionSheet showInView:self.view];

}

#pragma mark - Action Sheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  NSURL *url = [NSURL URLWithString:self.item.link];
  switch (buttonIndex) {
    case 0: //safari
      [[UIApplication sharedApplication] openURL:url];
      break;
    case 1: { //more options

  UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[url]
                                                                                       applicationActivities:nil];
    [self presentViewController:activityViewController
                       animated:YES
                     completion:^{
                         
                     }];
      break;
    }
    default:
      break;
  }
  
}
@end
