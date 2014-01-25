//
//  JGAppDelegate.h
//  ynnuS
//
//  Created by Jason Garrett on 1/17/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootNavigationViewController;

@interface JGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootNavigationViewController *rootNavigationController;

- (NSURL *)applicationDocumentsDirectory;


-(void)showHud:(NSString*)message;
-(void)hideHud;

@end
