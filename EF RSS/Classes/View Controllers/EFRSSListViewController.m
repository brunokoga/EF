//
//  EFRSSListViewController.m
//  EF RSS
//
//  Created by Bruno Koga on 3/4/14.
//  Copyright (c) 2014 Bruno Koga. All rights reserved.
//

#import "EFRSSListViewController.h"
#import "EFCoreDataManager.h"
#import "EFRSSItemCell.h"
#import "RSSItem.h"
#import "EFDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "EFRSSDownloaderManager.h"

@interface EFRSSListViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation EFRSSListViewController
static NSString * const kTableViewCellRSSItemReuseIdentifier = @"kTableViewCellRSSItemReuseIdentifier";


- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setUpPullToRefresh];
  //hide search bar
  [self.tableView setContentOffset:CGPointMake(0, 44.0)];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  if (self.selectedIndexPath) {
    [self.tableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
    self.selectedIndexPath = nil;
  }
}

- (void)setUpPullToRefresh
{
  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refresh RSS Feed"];
  [refreshControl addTarget:self action:@selector(refreshTable)
           forControlEvents:UIControlEventValueChanged];
  self.refreshControl = refreshControl;
  [self.tableView addSubview:refreshControl];
}

- (void)refreshTable {
  [self.refreshControl beginRefreshing];
  [[EFRSSDownloaderManager sharedManager] downloadWithCompletion:^(BOOL finished) {
    [self.refreshControl endRefreshing];
  }];
}

#pragma mark - Fetched Results Controller

//singleton + lazy load

- (NSFetchedResultsController *)fetchedResultsControllerForSearchTerm:(NSString *)searchTerm
{
  if (_fetchedResultsController) {
    return _fetchedResultsController;
  }
  NSManagedObjectContext *managedObjectContext = [[EFCoreDataManager sharedManager] managedObjectContext];

  //if there is a search term, then we add the search predicates
    NSFetchRequest *fetchRequest = nil;
  fetchRequest = [NSFetchRequest new];
  [fetchRequest setEntity:[NSEntityDescription entityForName:@"RSSItem"
                                      inManagedObjectContext:managedObjectContext]];

    NSString *cacheName = @"RSSCache";
  if ([searchTerm length] > 0) {
    NSPredicate *searchInTitlePredicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@", searchTerm];
    NSPredicate *searchInDescriptionPredicate = [NSPredicate predicateWithFormat:@"itemDescription contains[cd] %@", searchTerm];
    NSCompoundPredicate *compoundPredicate = [[NSCompoundPredicate alloc] initWithType:NSOrPredicateType
                                                                         subpredicates:@[searchInTitlePredicate, searchInDescriptionPredicate]];

    [fetchRequest setPredicate:compoundPredicate];
    cacheName = [cacheName stringByAppendingString:searchTerm];
  }
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
  [fetchRequest setSortDescriptors:@[sortDescriptor]];
 

  NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                             managedObjectContext:managedObjectContext
                                                                                               sectionNameKeyPath:nil
                                                                                                        cacheName:cacheName];
  
  
  [self setFetchedResultsController:fetchedResultsController];
  fetchedResultsController.delegate = self;
  
  NSError *error;

  [fetchedResultsController performFetch:&error];
  if (error) {
    //TODO: treat the error accordingly
  }
  [self.tableView reloadData];
  
  return fetchedResultsController;
  
}
- (NSFetchedResultsController *)fetchedResultsController {
  return [self fetchedResultsControllerForSearchTerm:nil];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView beginUpdates];
  
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                            withRowAnimation:UITableViewRowAnimationAutomatic];
      break;
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                            withRowAnimation:UITableViewRowAnimationAutomatic];
      break;
    case NSFetchedResultsChangeUpdate: {
      EFRSSItemCell *cell;
      RSSItem *item;
      item = [self.fetchedResultsController objectAtIndexPath:indexPath];
      cell = (EFRSSItemCell *)[self.tableView cellForRowAtIndexPath:indexPath];
      [self configureCell:cell forItem:item];
      break;
    }
    case NSFetchedResultsChangeMove:
      [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                            withRowAnimation:UITableViewRowAnimationAutomatic];
      [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                            withRowAnimation:UITableViewRowAnimationAutomatic];
      break;

    default:
      break;
  }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
  NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sectionIndex];
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [self.tableView insertSections:indexSet
                    withRowAnimation:UITableViewRowAnimationAutomatic];
      break;
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteSections:indexSet
                    withRowAnimation:UITableViewRowAnimationAutomatic];
      break;
    default:
      break;
  }
}

#pragma Configure Cell

- (void)configureCell:(EFRSSItemCell *)cell forItem:(RSSItem *)item {
  cell.titleLabel.text = item.title;
  cell.descriptionLabel.text = item.itemDescription;
  [cell.imageView setImageWithURL:[NSURL URLWithString:item.media]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSArray *sections = [self.fetchedResultsController sections];
  id<NSFetchedResultsSectionInfo> sectionInfo;
  sectionInfo = sections[section];
  return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  EFRSSItemCell *cell;
  RSSItem *item;
  item = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellRSSItemReuseIdentifier];
  [self configureCell:cell forItem:item];
  
  return cell;
  
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[self.fetchedResultsController sections] count];
}

#pragma mark - UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//  self.selectedIndexPath = indexPath;
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  self.selectedIndexPath = indexPath;
  return indexPath;
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  [self setSearchTerm:searchText];
}

- (void)setSearchTerm:(NSString *)searchTerm {
  self.fetchedResultsController = nil;
  [self fetchedResultsControllerForSearchTerm:searchTerm];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
  [searchBar setText:@""];
  [self setSearchTerm:@""];
  [searchBar resignFirstResponder];
}

#pragma mark - Segue

static NSString * const ListToDetailSegue = @"ListToDetailSegue";

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:ListToDetailSegue])
  {
    EFDetailViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.item = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
  }
}

@end
