//
//  RootNavigationViewController.m
//  ynnuS
//
//  Created by Jason Garrett on 11/28/13.
//  Copyright (c) 2013 Ulnar Nerve LLC. All rights reserved.
//

#import "RootNavigationViewController.h"

#import "SoundsListTableViewController.h"

#import "RecordSoundViewController.h"
#import "PlaySoundViewController.h"

#import "RemoteHTMLViewController.h"

#import "SettingsTableViewController.h"

@interface RootNavigationViewController ()

@end

@implementation RootNavigationViewController

-(id)init {
    
    self = [super init];
    
    if (self) {
        
        SoundsListTableViewController *vc = [[SoundsListTableViewController alloc] initWithStyle:UITableViewStylePlain];
        self.viewControllers = @[vc];
        
    }
    
    return self;
}

-(void)addRecordViewController:(id)aDelegate {
    
    
    RecordSoundViewController *vc = [[UIStoryboard storyboardWithName:@"Record" bundle:nil] instantiateViewControllerWithIdentifier:@"Record"];
    [self pushViewController:vc animated:YES];
    
}

-(void)showPlayViewController:(id)aDelegate andSound:(Sound*)aSound {
    
    PlaySoundViewController *vc = [[UIStoryboard storyboardWithName:@"Play" bundle:nil] instantiateViewControllerWithIdentifier:@"Play"];
    vc.soundModel = aSound;

    [self pushViewController:vc animated:YES];
    
}

-(void)showInfoViewController {
    
    SettingsTableViewController *vc = [[UIStoryboard storyboardWithName:@"Info" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingsTableViewController"];
    [self pushViewController:vc animated:YES];
    
}


-(void)showRemoteHTMLViewController:(NSURL*)aURL navTitle:(NSString*)navTitle {
    
    RemoteHTMLViewController *vc = [[UIStoryboard storyboardWithName:@"Info" bundle:nil] instantiateViewControllerWithIdentifier:@"RemoteHTMLViewController"];
    vc.url = aURL;
    vc.title = navTitle;
    [self pushViewController:vc animated:YES];
    
}
@end
