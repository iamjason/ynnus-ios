//
//  AppearanceViewController.m
//  ynnuS
//
//  Created by Jason Garrett on 1/24/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import "AppearanceViewController.h"

@interface AppearanceViewController ()

@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
@property (strong, nonatomic) IBOutlet UIButton *navigationBarButton;
@property (strong, nonatomic) IBOutlet UIButton *navigationTextLabel;

@end

@implementation AppearanceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self updateUI];
}

-(void)updateUI {
    
    self.button1.backgroundColor = COLOR_BUTTON_PRIMARY;
    self.button2.backgroundColor = COLOR_BUTTON_SECONDARY;
    self.button3.backgroundColor = COLOR_BUTTON_THIRD;
    self.button4.backgroundColor = COLOR_BUTTON_RECORD;
    
    self.navigationBarButton.backgroundColor = COLOR_NAVIGATIONBAR_BACKGROUND;
    self.navigationTextLabel.backgroundColor = COLOR_NAVIGATIONBAR_TITLE;
    
    
}

@end
