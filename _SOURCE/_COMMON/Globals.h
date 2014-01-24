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

#define UINAVIGATIONBAR_TINT_COLOR [UIColor colorWithRed:0.737 green:0.843 blue:0.961 alpha:1.000]
#define VIEW_BACKGROUND_COLOR [UIColor colorWithRed:0.836 green:0.901 blue:0.945 alpha:1.000]
#define COLOR_BUTTON_RED [UIColor colorWithRed:0.945 green:0.181 blue:0.143 alpha:1.000]
#define COLOR_BUTTON_GREEN [UIColor colorWithRed:0.193 green:0.769 blue:0.352 alpha:1.000]
#define COLOR_BUTTON_BLUE [UIColor colorWithRed:0.310 green:0.409 blue:0.945 alpha:1.000]
#define UINAVIGATIONBAR_TITLE_COLOR [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000]

#define kAudioAlertViewSuccessTag 100
#define kAudioAlertViewFailureTag 101

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@interface Globals : NSObject

@end
