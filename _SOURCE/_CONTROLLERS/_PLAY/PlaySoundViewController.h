//
//  PlaySoundViewController.h
//  ynnuS
//
//  Created by Jason Garrett on 1/21/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Sound.h"

typedef enum
{
    kPlayUIStatesStopped,
    kPlayUIStatesPlaying,
    kPlayUIStatesPlayingBackwards,
    
} PlayUIStates;


@interface PlaySoundViewController : UIViewController

@property (strong, nonatomic) Sound *soundModel;

@end
