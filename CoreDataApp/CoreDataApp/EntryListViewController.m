//
//  EntryListViewController.m
//  CoreDataApp
//
//  Created by Venkatesh Jujjavarapu on 10/21/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import "EntryListViewController.h"
#import "CoreDataStack.h"
#import "DiaryEntry+CoreDataProperties.h"
#import "NewEntryViewController.h"
#import "EntryCell.h"
@interface EntryListViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation EntryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200.0f;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Fetch Trigger to Initiate !
    [self.fetchedResultsController performFetch:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSFetchRequest *)entryListFetchRequest {
    
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"DiaryEntry"];
    
    // Predicate/ Conditions similar to WHERE clause in SQL
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
  
    return fetchRequest;
    
    
}
// Getter for fetchedResultsController
-(NSFetchedResultsController *)fetchedResultsController {
    
    
    // Lazy loading
    if(_fetchedResultsController!=nil)
    {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:@"sectionName" cacheName:nil];
    
    
    // Wont fetch data without this part!
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    

    
    
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    EntryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    DiaryEntry *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    [cell configureCellForEntry:entry];

    return cell;
}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView beginUpdates];
    
    
}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
          
            
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        default:
            break;
    }
 
}


//
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    /* Return an estimated height or calculate
//     * estimated height dynamically on information
//     * that makes sense in your case.
//     */
//    return 200.0f;
//}
-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    
    
    switch (type) {
        
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        default:
            break;
    }
   
    
    
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView endUpdates];
    
    
//    [self.tableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    return [sectionInfo name];
    
    
    
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    DiaryEntry *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    
    [coreDataStack.managedObjectContext deleteObject:entry];
    
//    [[coreDataStack managedObjectContext]deleteObject:entry];
    
    
    
    
    
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    
    if([segue.identifier isEqualToString:@"edit"])
    {
        
        UITableViewCell *cell = sender;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        
        NewEntryViewController *newEntryViewController = (NewEntryViewController *)navigationController.topViewController;
        
        
        
        newEntryViewController.entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
  }
    
   

}


@end
