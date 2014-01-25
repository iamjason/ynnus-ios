//
//  Globals.h
//  ynnuS
//
//  Created by Jason Garrett on 1/21/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGAppDelegate.h"

#define APP_DELEGATE ((JGAppDelegate *)([[UIApplication sharedApplication] delegate]))

#define FONT(s) [UIFont fontWithName:@"Avenir-Roman" size:s]
#define FONT_AVENIR_BOOK(s) [UIFont fontWithName:@"Avenir-Book" size:s]


#define COLOR_ONE       [UIColor colorWithRed:0.224 green:0.996 blue:0.663 alpha:1.000]
#define COLOR_TWO       [UIColor colorWithRed:0.188 green:0.800 blue:0.992 alpha:1.000]
#define COLOR_THREE     [UIColor colorWithRed:0.337 green:0.490 blue:0.988 alpha:1.000]
#define COLOR_FOUR      [UIColor colorWithRed:0.867 green:0.502 blue:0.910 alpha:1.000]
#define COLOR_FIVE      [UIColor colorWithRed:1.000 green:0.518 blue:0.112 alpha:1.000]



#define COLOR_VIEW_BACKGROUND               [UIColor whiteColor]

#define COLOR_NAVIGATIONBAR_BACKGROUND      COLOR_TWO
#define COLOR_NAVIGATIONBAR_TITLE           [UIColor whiteColor]

#define COLOR_BUTTON_RECORD                 COLOR_FOUR
#define COLOR_BUTTON_RECORD_TEXT            [UIColor whiteColor]


#define COLOR_BUTTON_PRIMARY                COLOR_TWO
#define COLOR_BUTTON_PRIMARY_TEXT           [UIColor whiteColor]

#define COLOR_BUTTON_SECONDARY              COLOR_THREE
#define COLOR_BUTTON_SECONDARY_TEXT         [UIColor whiteColor]

#define COLOR_BUTTON_THIRD             COLOR_ONE
#define COLOR_BUTTON_THIRD_TEXT         [UIColor whiteColor]



#define kAudioAlertViewSuccessTag 100
#define kAudioAlertViewFailureTag 101

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


//-------------------------------------------------------------------------------------------------------------------------------------------------
//#define sheme_white
////#define sheme_black
////-------------------------------------------------------------------------------------------------------------------------------------------------
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//#define HUD_STATUS_FONT			[UIFont fontWithName:@"Avenir-Roman" size:20]//[UIFont boldSystemFontOfSize:16]
////-------------------------------------------------------------------------------------------------------------------------------------------------
//#ifdef sheme_white
//#define HUD_STATUS_COLOR		[UIColor whiteColor]
//#define HUD_SPINNER_COLOR		[UIColor whiteColor]
//#define HUD_BACKGROUND_COLOR	[UIColor colorWithRed:0.188 green:0.800 blue:0.992 alpha:0.700]
//#define HUD_IMAGE_SUCCESS		[UIImage imageNamed:@"ProgressHUD.bundle/success-white.png"]
//#define HUD_IMAGE_ERROR			[UIImage imageNamed:@"ProgressHUD.bundle/error-white.png"]
//#endif
////-------------------------------------------------------------------------------------------------------------------------------------------------
//#ifdef sheme_black
//#define HUD_STATUS_COLOR		[UIColor blackColor]
//#define HUD_SPINNER_COLOR		[UIColor blackColor]
//#define HUD_BACKGROUND_COLOR	[UIColor colorWithWhite:0 alpha:0.2]
//#define HUD_IMAGE_SUCCESS		[UIImage imageNamed:@"ProgressHUD.bundle/success-black.png"]
//#define HUD_IMAGE_ERROR			[UIImage imageNamed:@"ProgressHUD.bundle/error-black.png"]
//#endif
//-------------------------------------------------------------------------------------------------------------------------------------------------


@interface Globals : NSObject

@end
