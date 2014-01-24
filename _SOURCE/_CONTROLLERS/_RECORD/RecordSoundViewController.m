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

/**
 The recorder
 */
@property (nonatomic,strong) AVAudioRecorder *recorder;

@property (nonatomic,strong) AVAudioPlayer *player;

@property (strong, nonatomic) IBOutlet UIButton *stopButton;

@property (nonatomic, strong) IBOutlet UIButton *playButton;

@property (nonatomic, strong) IBOutlet UIButton *recordButton;

@property (strong, nonatomic) IBOutlet UIButton *playBackwards;

@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) IBOutlet UITextField *filenameTextField;

@end

@implementation RecordSoundViewController

@synthesize soundModel;

-(instancetype)init {
    
    self = [super init];
    if (self) {
        [self initVC];
    }
    return self;
    
}

-(void) initVC {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    self.soundModel = [Sound createEntity];
    self.soundModel.created = [NSDate date];
    
    self.recordButton.backgroundColor = COLOR_BUTTON_RED;
    self.saveButton.backgroundColor = COLOR_BUTTON_GREEN;
    
    self.title = NSLocalizedString(@"Record Sound", nil);
    
    self.filenameTextField.delegate = self;

    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSetting setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey]; // mono
	[recordSetting setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSetting setValue:[NSNumber numberWithFloat:16000.00] forKey:AVSampleRateKey];
    [recordSetting setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
	[recordSetting setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    // Initiate and prepare the recorder
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.soundModel.audioURLOriginal settings:recordSetting error:NULL];
    _recorder.delegate = self;
    _recorder.meteringEnabled = YES;
    [_recorder prepareToRecord];
    
    
}
-(void)viewWillDisappear:(BOOL)animated {
    if (self.soundModel.name.length == 0) {
        [self.soundModel deleteEntity];
    }
}
-(void)viewWillAppear:(BOOL)animated {
    
    [self updateUIState];
    
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
   
}

- (IBAction)_stop:(id)sender {
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    
    if (_recorder.recording) {
        [_recorder stop];
        
        [self startProcessingAudio];
    }
    
    if (_player) {
        
        [_player stop];
        [_player setCurrentTime:0];
        
    }
    
    self.currentState = kRecordUIStatesStopped;
    [self updateUIState];
    
}

- (IBAction)_record:(id)sender {
    
//    [self toggleRecording:nil];
    
    if (_player) {
        [_player stop];
    }
    
    
    if (!_recorder.recording) {
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // start recording
        [_recorder record];
        
    } else {
        
        // pause recording
        [_recorder pause];
    }
    
    self.currentState = kRecordUIStatesRecording;
    [self updateUIState];
    
    
    
}

- (IBAction)_play:(id)sender {
    
//    [self playFile:nil];
    
    if (!_recorder.isRecording) {
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_recorder.url error:nil];
        [_player setDelegate:self];
        [_player play];
    }
    
    self.currentState = kRecordUIStatesPlaying;
    [self updateUIState];
    
    
}

- (IBAction)_playBackwards:(id)sender {
    
    self.currentState = kRecordUIStatesPlayingBackwards;
    [self updateUIState];
    
}

- (IBAction)_saveRecording:(id)sender {
    
    self.soundModel.name = self.filenameTextField.text;
//    self.soundModel.created = [NSDate date];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        
        if (success) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                            message:@"Your sound has finished saving"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            alert.delegate = self;
            alert.tag = kAudioAlertViewSuccessTag;
            [alert show];
            
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

-(void)startProcessingAudio {
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
    UInt32 fileDataSize = 0;
    
    AudioStreamBasicDescription theFileFormat;
    UInt32 thePropertySize = sizeof(theFileFormat);
    
    theErr = AudioFileOpenURL((__bridge CFURLRef)self.soundModel.audioURLOriginal, kAudioFileReadPermission, 0, &inputAudioFile);
    
    if (theErr) {
        NSLog(@"ERROR OPENING ORIGINAL RECORDING");
    }
    
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
    
    NSLog(@"Fished saving reversed sound");
    
    //Also delete the recorded audio
//    NSError *error;
//    if (![[NSFileManager defaultManager] removeItemAtURL:self.soundModel.audioURLOriginal error:&error])
//		NSLog(@"Error: %@", [error localizedDescription]);
    

    
}
#pragma mark - AVAudioPlayerDelegate

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    
    self.currentState = kRecordUIStatesStopped;
    [self updateUIState];
    
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    self.currentState = kRecordUIStatesStopped;
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    
    return YES;
    
}




@end
