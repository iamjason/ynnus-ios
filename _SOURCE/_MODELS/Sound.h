//
//  Sound.h
//  ynnuS
//
//  Created by Jason Garrett on 1/17/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Sound : NSManagedObject

@property (nonatomic, strong) NSDate * created;
@property (nonatomic, strong) NSString * reversedRecordingLocation;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * originalRecordingLocation;

@property (nonatomic,readonly) NSString *fileNameOriginal;
@property (nonatomic,readonly) NSString *fileNameReversed;
@property (nonatomic,readonly) NSURL *audioURLOriginal;
@property (nonatomic,readonly) NSURL *audioURLReversed;


-(void)deleteSound;

@end
