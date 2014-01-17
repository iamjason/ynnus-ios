//
//  RootNavigationViewController.m
//  ynnuS
//
//  Created by Jason Garrett on 11/28/13.
//  Copyright (c) 2013 Ulnar Nerve LLC. All rights reserved.
//

#import "RootNavigationViewController.h"

#import "SoundsListTableViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end