//
//  JGAppDelegate.m
//  ynnuS
//
//  Created by Jason Garrett on 1/17/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import "JGAppDelegate.h"
#import "RootNavigationViewController.h"
#import <TestFlightSDK/TestFlight.h>
#import <ProgressHUD/ProgressHUD.h>

@import AVFoundation;

@implementation JGAppDelegate

@synthesize rootNavigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [TestFlight takeOff:@"a58c96f6-5b90-48c0-ae47-db7f6d714cbd"];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"ynnuS.v.1.0"];
    
    //
    [self initAudioSession];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.window.backgroundColor = COLOR_NAVIGATIONBAR_BACKGROUND;
    self.window.tintColor = COLOR_NAVIGATIONBAR_TITLE;
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                         COLOR_NAVIGATIONBAR_TITLE, NSForegroundColorAttributeName,
                                                          FONT(20), NSFontAttributeName, nil] forState:0];
    
    [[UINavigationBar appearance] setBarTintColor:COLOR_NAVIGATIONBAR_BACKGROUND];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           COLOR_NAVIGATIONBAR_TITLE, NSForegroundColorAttributeName,
                                                           FONT(20), NSFontAttributeName, nil]];
    
    [self.window makeKeyAndVisible];
    
    self.rootNavigationController = [[RootNavigationViewController alloc] init];
    self.window.rootViewController = self.rootNavigationController;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.

    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
       
    
    }];
    
}

#pragma mark - Application Initializations
-(void)initAudioSession {
    
    // audio session
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = NULL;
    
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&err];
    if( err ){
        NSLog(@"!!!ERROR!!! creating audio session");
    }
    
    [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:NULL];
    if( err ){
        NSLog(@"!!!ERROR!!! sending the audio to the speakers");
    }
    
}


-(void)showHud:(NSString*)message {
    [ProgressHUD show:message];
}
-(void)hideHud {
    [ProgressHUD dismiss];
}



#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
