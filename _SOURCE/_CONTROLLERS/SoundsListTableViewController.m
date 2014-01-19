//
//  SoundsListTableViewController.m
//  ynnuS
//
//  Created by Jason Garrett on 11/28/13.
//  Copyright (c) 2013 Ulnar Nerve LLC. All rights reserved.
//

#import "SoundsListTableViewController.h"
#import "Sound.h"

#import "EmptySoundsCell.h"

@interface SoundsListTableViewController ()

@property (nonatomic, strong) NSMutableArray *sounds;

@end

@implementation SoundsListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"My Recordings", @"SoundsListTable Header");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_addSound:)];
    self.navigationItem.rightBarButtonItem = addItem;
    
}

-(NSMutableArray*)sounds {
    
    if (!_sounds) {
        
        _sounds = [NSMutableArray array];
        
        // check CoreData for previously recorded sounds
        NSArray *savedSounds = [Sound MR_findAllSortedBy:@"created" ascending:NO];
        if (savedSounds.count > 0) {
            _sounds = [NSMutableArray arrayWithArray:savedSounds];
        }
        
    }
    
    return _sounds;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MAX(self.sounds.count, 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.sounds.count == 0) {
        
        EmptySoundsCell *empty = [[EmptySoundsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"emptyRecordings"];
        empty.textLabel.text = NSLocalizedString(@"No Recordings yet...", nil);
        return empty;
        
    }
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"cell: %i", indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
