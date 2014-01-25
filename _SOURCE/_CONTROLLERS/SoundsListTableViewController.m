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
#import "SoundListCell.h"

#import "RecordSoundViewController.h"
#import "PushButton.h"

@interface SoundsListTableViewController ()

@property (nonatomic, strong) NSMutableArray *sounds;
@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, assign) BOOL isShowingInfo;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeDown;

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

    self.view.backgroundColor = COLOR_VIEW_BACKGROUND;
    
    self.title = NSLocalizedString(@"ynnuƧ", @"SoundsListTable Header");
    [self.tableView registerNib:[UINib nibWithNibName:@"SoundListCell"  bundle:nil]
         forCellReuseIdentifier:@"SoundListCell"];
    
    [self reload];
    
    
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavBarLogo"]];
    self.navigationItem.title = @"";
//    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_addSound:)];
//    self.navigationItem.rightBarButtonItem = addItem;
    PushButton *addButton = [PushButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 0, 48, 40);
    [[addButton titleLabel] setFont:FONT(18)];
    [[addButton titleLabel] setTextColor:[UIColor whiteColor]];
    [addButton setTitle:@"New" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(_addSound:) forControlEvents:UIControlEventTouchUpInside];
    
    addButton.backgroundColor = [UIColor clearColor];//COLOR_BUTTON_THIRD;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    
    PushButton *infoButton = [PushButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(0, 0, 70, 40);
    [[infoButton titleLabel] setFont:FONT(18)];
    [[infoButton titleLabel] setTextColor:[UIColor whiteColor]];
    [infoButton setTitle:@"Settings" forState:UIControlStateNormal];
    infoButton.backgroundColor = [UIColor clearColor];
    //COLOR_BUTTON_SECONDARY;
    [infoButton addTarget:self action:@selector(_showInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [self reload];
   
    
}
-(void)viewDidAppear:(BOOL)animated {
     [self reload];
}

-(NSMutableArray*)sounds {
    
    if (!_sounds) {
        
        [self refreshCoreData];
        
    }
    
    return _sounds;
}

-(void)reload {
    
    [self refreshCoreData];
    [self.tableView reloadData];
    
}

-(void)refreshCoreData {
    
    // check CoreData for previously recorded sounds
    NSArray *savedSounds = [Sound MR_findAllSortedBy:@"created" ascending:NO];
    if (savedSounds.count > 0) {
        _sounds = [NSMutableArray arrayWithArray:savedSounds];
    }
    else
    {
        _sounds = [NSMutableArray array];
    }
    
}

-(void)_showInfo:(id)sender {
    [APP_DELEGATE.rootNavigationController showInfoViewController];
}

-(void)_addSound:(id)sender {
    
    [APP_DELEGATE.rootNavigationController addRecordViewController:self];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
    
    // just show the empty cell if we're empty
    
    if (self.sounds.count == 0) {
        
        EmptySoundsCell *empty = [[EmptySoundsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"emptyRecordings"];
        empty.textLabel.text = NSLocalizedString(@"No Recordings yet...", nil);
        
        return empty;
        
    }
    
    // otherwise, display the SoundListCell
    
    static NSString *CellIdentifier = @"SoundListCell";
    SoundListCell *cell = (SoundListCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.delegate = self;
    
    if (indexPath.row < self.sounds.count) {
        Sound *soundModel = self.sounds[indexPath.row];
        cell.soundModel = soundModel;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.sounds.count > 0) {
        
        if (indexPath.row < self.sounds.count) {
            Sound *soundModel = self.sounds[indexPath.row];
            [APP_DELEGATE.rootNavigationController showPlayViewController:self andSound:soundModel];
        }
        
        
    } else {
        [APP_DELEGATE.rootNavigationController addRecordViewController:nil];
    }
    
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
