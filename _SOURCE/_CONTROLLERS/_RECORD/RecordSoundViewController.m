//
//  RecordSoundViewController.m
//  ynnuS
//
//  Created by Jason Garrett on 1/17/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import "RecordSoundViewController.h"
#import "Globals.h"

@import AVFoundation;

@interface RecordSoundViewController () <AVAudioPlayerDelegate,AVAudioRecorderDelegate,UIAlertViewDelegate,UITextFieldDelegate>


@property (nonatomic,assign) RecordUIStates currentState;


@property (strong) AVAudioSession *session;
@property (strong) AVAudioRecorder *recorder;
@property (strong) AVAudioPlayer *player;
@property (strong) NSURL *audioURLOriginal;
@property (strong) NSURL *audioURLReversed;

@property (assign) BOOL hasSavedAudio;

//@property (nonatomic,strong) AVAudioSession *session;
//
//@property (nonatomic,strong) AVAudioRecorder *recorder;
//
//@property (nonatomic,strong) AVAudioPlayer *player;

@property (strong, nonatomic) IBOutlet UIButton *stopButton;

@property (nonatomic, strong) IBOutlet UIButton *playButton;

@property (nonatomic, strong) IBOutlet UIButton *recordButton;

@property (strong, nonatomic) IBOutlet UIButton *playBackwards;

@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) IBOutlet UITextField *filenameTextField;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;


@end

@implementation RecordSoundViewController

@synthesize session;
@synthesize recorder;
@synthesize player;
@synthesize audioURLOriginal;
@synthesize audioURLReversed;

@synthesize soundModel;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_VIEW_BACKGROUND;
    self.soundModel = [Sound createEntity];
    self.soundModel.created = [NSDate date];
    
    
    self.filenameTextField.delegate = self;
    self.filenameTextField.layer.cornerRadius = 8;
    self.filenameTextField.layer.masksToBounds = YES;
    self.filenameTextField.backgroundColor = COLOR_ONE;
    self.filenameTextField.textColor = COLOR_BUTTON_PRIMARY_TEXT;
    
    self.stopButton.backgroundColor =
    self.recordButton.backgroundColor = COLOR_TWO;
    
    self.playButton.backgroundColor = COLOR_THREE;
    self.playBackwards.backgroundColor = COLOR_FOUR;
    
    self.saveButton.backgroundColor = COLOR_FIVE;
    
    self.title = NSLocalizedString(@"Record Sound", nil);
    
    [self updateUIState];
	if ([self startAudioSession])
    {
		[self prepareToRecord];
    }
}

-(void)viewDidDisappear:(BOOL)animated {
    
    if ( !self.hasSavedAudio ) {
        [self.soundModel deleteSound];
    }
    
    [self.view endEditing:YES];
    [self.view removeGestureRecognizer:self.tapGesture];
    
}
-(void)viewDidAppear:(BOOL)animated {
    [self updateUIState];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapped:)];
    [self.view addGestureRecognizer:self.tapGesture];
    
}


-(void)_tapped:(UITapGestureRecognizer*)tap {
    [self.view endEditing:YES];
}

-(void)updateUIState {
    
    self.stopButton.hidden =
    self.recordButton.hidden =
    self.saveButton.hidden =
    self.playBackwards.hidden =
    self.playButton.hidden = YES;
    
    switch (self.currentState) {
            
        case kRecordUIStatesFirstRun:{
            self.recordButton.hidden = NO;
        } break;
            
        case kRecordUIStatesRecording:{
            self.stopButton.hidden = NO;
        } break;
            
        case kRecordUIStatesPlayingBackwards:
        case kRecordUIStatesPlaying:{
            self.stopButton.hidden = NO;
        } break;
    
        case kRecordUIStatesStopped:{
            self.saveButton.hidden = 
            self.recordButton.hidden =
            self.playButton.hidden = 
            self.playBackwards.hidden = NO;
        } break;
            
    }
   
    [self.view endEditing:YES];
    
}

- (IBAction)_stop:(id)sender {
 
    if (self.player.isPlaying) {
        
        [self stopPlaying];
        
    }
    
    if (self.recorder.isRecording) {
    
        [self stopRecording];
        
    }
    
    self.currentState = kRecordUIStatesStopped;
    [self updateUIState];
    
}

- (IBAction)_record:(id)sender {
   
    [self startRecording];
    self.currentState = kRecordUIStatesRecording;
    [self updateUIState];
    
    
    
}

- (IBAction)_play:(id)sender {
    
    [self startPlaying];
    self.currentState = kRecordUIStatesPlaying;
    [self updateUIState];
    
    
}

- (IBAction)_playBackwards:(id)sender {
 
    [self startPlayingReversed];
    self.currentState = kRecordUIStatesPlayingBackwards;
    [self updateUIState];
    
}

- (IBAction)_saveRecording:(id)sender {
    
    if (self.filenameTextField.text.length > 0) {
        self.soundModel.name = self.filenameTextField.text;
    } else {
        self.soundModel.name = @"Sound";
    }
    
//    self.soundModel.created = [NSDate date];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        
        if (success) {
            self.hasSavedAudio = YES;

            [self.navigationController popViewControllerAnimated:YES];
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
//                                                            message:@"Your sound has finished saving"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            alert.delegate = self;
//            alert.tag = kAudioAlertViewSuccessTag;
//            [alert show];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                            message:@"Something went wrong... please try again."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            alert.delegate = self;
            alert.tag = kAudioAlertViewFailureTag;
            [alert show];
        }
        
    }];
    
}

-(void)reverseAudio {
    
        [APP_DELEGATE performSelectorOnMainThread:@selector(showHud:) withObject:@"Processing Audio Data..." waitUntilDone:YES];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^(void) {
           
        /*
         As each sample is 16-bits in size(2 bytes)(mono channel).
         You can load each sample at a time by copying it into a different buffer by starting at the end of the recording and
         reading backwards. When you get to the start of the data you have reversed the data and playing will be reversed.
         */
        
        // set up output file
        AudioFileID outputAudioFile;
        
        AudioStreamBasicDescription myPCMFormat;
        myPCMFormat.mSampleRate = 16000.00;
        myPCMFormat.mFormatID = kAudioFormatLinearPCM ;
        myPCMFormat.mFormatFlags =  kAudioFormatFlagsCanonical;
        myPCMFormat.mChannelsPerFrame = 1;
        myPCMFormat.mFramesPerPacket = 1;
        myPCMFormat.mBitsPerChannel = 16;
        myPCMFormat.mBytesPerPacket = 2;
        myPCMFormat.mBytesPerFrame = 2;
        
        
        AudioFileCreateWithURL((__bridge CFURLRef)self.soundModel.audioURLReversed,
                               kAudioFileCAFType,
                               &myPCMFormat,
                               kAudioFileFlags_EraseFile,
                               &outputAudioFile);
        // set up input file
        AudioFileID inputAudioFile;
        OSStatus theErr = noErr;
        UInt64 fileDataSize = 0;
        
        AudioStreamBasicDescription theFileFormat;
        UInt32 thePropertySize = sizeof(theFileFormat);
        
        theErr = AudioFileOpenURL((__bridge CFURLRef)self.soundModel.audioURLOriginal, kAudioFileReadPermission, 0, &inputAudioFile);
        
        thePropertySize = sizeof(fileDataSize);
        theErr = AudioFileGetProperty(inputAudioFile, kAudioFilePropertyAudioDataByteCount, &thePropertySize, &fileDataSize);
        
        UInt32 dataSize = fileDataSize;
        void* theData = malloc(dataSize);
        
        //Read data into buffer
        UInt32 readPoint  = dataSize;
        UInt32 writePoint = 0;
        while( readPoint > 0 )
        {
            UInt32 bytesToRead = 2;
            
            AudioFileReadBytes( inputAudioFile, false, readPoint, &bytesToRead, theData );
            AudioFileWriteBytes( outputAudioFile, false, writePoint, &bytesToRead, theData );
            
            writePoint += 2;
            readPoint -= 2;
        }
        
        free(theData);
        AudioFileClose(inputAudioFile);
        AudioFileClose(outputAudioFile);
        
        //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [APP_DELEGATE performSelectorOnMainThread:@selector(hideHud) withObject:nil waitUntilDone:NO];
        //});
        
    });
    
    
    
    
}
#pragma mark -
#pragma mark AVAudioPlayerDelegate methods
#pragma mark -

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{

    self.currentState = kRecordUIStatesStopped;
    [self updateUIState];

    [self reverseAudio];
    NSLog(@"File saved to %@", [[self.soundModel.audioURLOriginal path] lastPathComponent]);
    
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{

    self.currentState = kRecordUIStatesStopped;
    [self updateUIState];

}


#pragma mark -
#pragma mark Private methods
#pragma mark -

- (void) stopRecording
{
	[self.recorder stop];
    
    
}


- (void)startRecording
{
 	if (![self.recorder record])
	{
		NSLog(@"Error: Record failed");
	}
}

-(void)prepareToRecord
{
	NSError *error;
	
	// Recording settings
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
	[settings setValue: [NSNumber numberWithFloat:16000.00] forKey:AVSampleRateKey];
	[settings setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey]; // mono
	[settings setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
	[settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
	[settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];

	// Create recorder
	self.recorder = [[AVAudioRecorder alloc] initWithURL:self.soundModel.audioURLOriginal settings:settings error:&error];
	if (!self.recorder)
	{
		NSLog(@"Error: %@", [error localizedDescription]);
	}
	
	// Initialize degate, metering, etc.
	self.recorder.delegate = self;
	
	if (![self.recorder prepareToRecord])
	{
		NSLog(@"Error: Prepare to record failed");
	}
    
}

-(void)startPlayingReversed
{
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.soundModel.audioURLReversed error:nil];
    player.delegate = self;
    if(![self.player play])
    {
        NSLog(@"Error: Play failed");
    }
}
-(void)startPlaying
{
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.soundModel.audioURLOriginal error:nil];
    player.delegate = self;
    if(![self.player play])
    {
        NSLog(@"Error: Play failed");
    }
}

-(void)stopPlaying
{
    [self.player stop];
}


- (BOOL) startAudioSession
{
	NSLog(@"startAudioSession");
	// Prepare the audio session
	NSError *error;
	self.session = [AVAudioSession sharedInstance];
	
	if (![self.session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error])
	{
		NSLog(@"Error: %@", [error localizedDescription]);
		return NO;
	}
	
	if (![self.session setActive:YES error:&error])
	{
		NSLog(@"Error: %@", [error localizedDescription]);
		return NO;
	}
    
	return self.session.inputAvailable;//make sure ;)
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    
    return YES;
    
}




@end
