//
//  RecordSoundViewController.h
//  ynnuS
//
//  Created by Jason Garrett on 1/17/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Sound.h"
typedef enum
{
    kRecordUIStatesFirstRun,
    kRecordUIStatesRecording,
    kRecordUIStatesStopped,
    kRecordUIStatesPlaying,
    kRecordUIStatesPlayingBackwards,
    
} RecordUIStates;

@interface RecordSoundViewController : UIViewController

@property (strong, nonatomic) Sound *soundModel;

@end
