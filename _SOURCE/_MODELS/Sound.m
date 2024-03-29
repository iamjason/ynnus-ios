//
//  Sound.m
//  ynnuS
//
//  Created by Jason Garrett on 1/17/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import "Sound.h"


@implementation Sound

@dynamic created;
@dynamic reversedRecordingLocation;
@dynamic name;
@dynamic originalRecordingLocation;

-(NSString*)fileNameOriginal {

    NSString *aStr = [NSString stringWithFormat:@"%.0f_Sound_ORG.aac", self.created.timeIntervalSince1970 ];
    NSLog(@"\n\nfileName: %@\n\n", aStr);
    return aStr;
    
}
-(NSString*)fileNameReversed {
    
    NSString *aStr = [NSString stringWithFormat:@"%.0f_Sound_REV.aac", self.created.timeIntervalSince1970 ];
    NSLog(@"\n\nfileName: %@\n\n", aStr);
    return aStr;
    
}

#pragma mark - Utility
-(NSArray*)applicationDocuments {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
}

-(NSString*)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

-(NSURL*)audioURLOriginal {
    
    NSString *str = [DOCUMENTS_FOLDER stringByAppendingPathComponent:self.fileNameOriginal];
    NSURL *url = [NSURL fileURLWithPath:str];
    NSLog(@"%@ \n\n%@\n\n", str, url);
    
    return url;
}

-(NSURL*)audioURLReversed {
    
    NSString *str = [DOCUMENTS_FOLDER stringByAppendingPathComponent:self.fileNameReversed];
    NSURL *url = [NSURL fileURLWithPath:str];
    NSLog(@"%@ \n\n%@\n\n", str, url);
    
    return [NSURL fileURLWithPath:str];
}

@end
