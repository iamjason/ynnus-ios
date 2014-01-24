//
//  PlaySoundViewController.m
//  ynnuS
//
//  Created by Jason Garrett on 1/21/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import "PlaySoundViewController.h"
#import "Globals.h"

@import AVFoundation;

@interface PlaySoundViewController () <UIAlertViewDelegate,AVAudioPlayerDelegate>

@property (nonatomic, assign) PlayUIStates currentState;

@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *playBackwardsButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;

@property (nonatomic,strong) AVAudioPlayer *player;

@end

@implementation PlaySoundViewController

@synthesize soundModel;

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
	
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    // Do any additional setup after loading the view.
    self.title = self.soundModel.name;
    self.deleteButton.backgroundColor = COLOR_BUTTON_RED;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self updateUIState];
    
}

-(void)updateUIState {
    
    self.stopButton.hidden =
    self.deleteButton.hidden =
    self.playBackwardsButton.hidden =
    self.playButton.hidden = YES;
    
    switch (self.currentState) {
            
        case kPlayUIStatesPlaying:
        case kPlayUIStatesPlayingBackwards:{
            self.stopButton.hidden = NO;
        } break;
            
        case kPlayUIStatesStopped:{
            self.deleteButton.hidden =
            self.playButton.hidden =
            self.playBackwardsButton.hidden = NO;
        } break;
            
    }
    
}

- (IBAction)_stop:(id)sender {
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];

    if (_player) {
        
        [_player stop];
        [_player setCurrentTime:0];
        
    }

    
    self.currentState = kPlayUIStatesStopped;
    [self updateUIState];
    
}


- (IBAction)_play:(id)sender {
    
    //    [self playFile:nil];
    
    if (!_player) {
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.soundModel.audioURLOriginal error:nil];
        [_player setDelegate:self];
       
    }
    [_player setCurrentTime:0];
    
     [_player play];
    
    self.currentState = kPlayUIStatesPlaying;
    [self updateUIState];
    
    
}

- (IBAction)_playBackwards:(id)sender {
    
    self.currentState = kPlayUIStatesPlayingBackwards;
    [self updateUIState];
    
}

- (IBAction)_delete:(id)sender {
    
    [self.soundModel deleteEntity];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        
        if (success) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your sound has been deleted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.delegate = self;
            alert.tag = kAudioAlertViewSuccessTag;
            [alert show];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.delegate = self;
            alert.tag = kAudioAlertViewFailureTag;
            [alert show];
        }
        
    }];
}

#pragma mark - AVAudioPlayerDelegate

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    self.currentState = kPlayUIStatesStopped;
    [self updateUIState];
    
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (alertView.tag) {
            
        case kAudioAlertViewSuccessTag:{
            [self.navigationController popViewControllerAnimated:YES];
        }break;
            
        case kAudioAlertViewFailureTag:{
            // don't navigate back
        }break;
            
    }
    
    
}
@end
