//
//  EFSettingsViewController.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFSettingsViewController.h"
#import "EFSettings.h"
#import "EFRSSDownloaderManager.h"

@interface EFSettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *feedTextField;

@end

@implementation EFSettingsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.feedTextField.text = [EFSettings feedURLString];
	// Do any additional setup after loading the view.
}

#pragma mark - IBActions
- (IBAction)doneButtonTouched:(id)sender {
  //TODO: validate the URL
  [EFSettings setFeedURLString:self.feedTextField.text];
  [self dismissViewControllerAnimated:YES
                           completion:^{
                             [[EFRSSDownloaderManager sharedManager] download];
                           }];
}

- (IBAction)cancelButtonTouched:(id)sender {
  [self dismissViewControllerAnimated:YES
                           completion:^{
                             
                           }];
}

- (IBAction)restoreToDefaultButtonTouched:(id)sender {
  self.feedTextField.text = [EFSettings defaultFeedURLString];
}
@end
