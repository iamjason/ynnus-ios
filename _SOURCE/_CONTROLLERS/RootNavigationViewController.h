//
//  RootNavigationViewController.h
//  ynnuS
//
//  Created by Jason Garrett on 11/28/13.
//  Copyright (c) 2013 Ulnar Nerve LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootNavigationViewController : UINavigationController

-(void)addRecordViewController:(id)aDelegate;

-(void)showPlayViewController:(id)aDelegate andSound:(Sound*)aSound;

-(void)showInfoViewController;

@end
