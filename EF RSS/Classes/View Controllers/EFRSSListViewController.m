//
//  EFRSSListViewController.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFRSSListViewController.h"
#import "EFCoreDataManager.h"

@interface EFRSSListViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation EFRSSListViewController
static NSString * const kTableViewCellRSSItemReuseIdentifier = @"kTableViewCellRSSItemReuseIdentifier";


- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellRSSItemReuseIdentifier];
	// Do any additional setup after loading the view.
}


#pragma mark - Fetched Results Controller

//singleton + lazy load
- (NSFetchedResultsController *)fetchedResultsController {
  if (_fetchedResultsController) {
    return _fetchedResultsController;
  }
  
  NSManagedObjectContext *managedObjectContext = [[EFCoreDataManager sharedManager] managedObjectContext];
  
  NSFetchRequest *fetchRequest = nil;
  fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RSSItem"];
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
  [fetchRequest setSortDescriptors:@[sortDescriptor]];
  
  NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                             managedObjectContext:managedObjectContext
                                                                                               sectionNameKeyPath:nil
                                                                                                        cacheName:@"RSSCache"];
  
  [self setFetchedResultsController:fetchedResultsController];
  self.fetchedResultsController.delegate = self;
  
  NSError *error;
  [self.fetchedResultsController performFetch:&error];
  if (error) {
    //TODO: treat the error accordingly
  }
  
  return fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSArray *sections = [self.fetchedResultsController sections];
  id<NSFetchedResultsSectionInfo> sectionInfo;
  sectionInfo = sections[section];
  return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell;
  NSManagedObject *object;
  object = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellRSSItemReuseIdentifier];
  cell.textLabel.text = [object valueForKey:@"title"];
  return cell;
  
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[self.fetchedResultsController sections] count];
}

@end
