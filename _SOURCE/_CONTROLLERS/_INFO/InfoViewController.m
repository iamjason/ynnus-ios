//
//  InfoViewController.m
//  ynnuS
//
//  Created by Jason Garrett on 1/23/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@property (nonatomic, strong) UILabel *debugLabel;

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView {
    UIView *v = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    v.backgroundColor = VIEW_BACKGROUND_COLOR;
    self.view = v;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    
    self.debugLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 300, 30)];
//    self.debugLabel.backgroundColor = COLOR_BUTTON_GREEN;
    
    self.debugLabel.font = FONT_AVENIR_BOOK(20);
    
    
    NSString *debugString = [NSString stringWithFormat:@"Version: %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    self.debugLabel.text = debugString;
    
    [self.view addSubview:self.debugLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
