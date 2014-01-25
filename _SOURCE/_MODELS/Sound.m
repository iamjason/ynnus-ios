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

-(NSString*)fileExtension {
    return @"aac";//@"mp3";//
}

-(NSString*)fileNameOriginal {

    NSString *aStr = [NSString stringWithFormat:@"%.0f_Sound_ORG", self.created.timeIntervalSince1970 ];
    NSLog(@"\n\nfileName: %@\n\n", aStr);
    return aStr;
    
}
-(NSString*)fileNameReversed {
    
    NSString *aStr = [NSString stringWithFormat:@"%.0f_Sound_REV", self.created.timeIntervalSince1970 ];
    NSLog(@"\n\nfileName: %@\n\n", aStr);
    return aStr;
    
}

-(NSURL*)audioURLOriginal {
    
    NSString *recordPath= [DOCUMENTS_FOLDER stringByAppendingPathComponent:self.fileNameOriginal];
	return [[NSURL alloc ] initFileURLWithPath:recordPath];
    
    NSString *str = [DOCUMENTS_FOLDER stringByAppendingPathComponent:self.fileNameOriginal];
    NSURL *url = [NSURL fileURLWithPath:str];
    NSLog(@"%@ \n\n%@\n\n", str, url);
    
    return url;
}

-(NSURL*)audioURLReversed {
    
    NSString *recordPath= [DOCUMENTS_FOLDER stringByAppendingPathComponent:self.fileNameReversed];
	return [[NSURL alloc ] initFileURLWithPath:recordPath];
    
    NSString *str = [DOCUMENTS_FOLDER stringByAppendingPathComponent:self.fileNameReversed];
    NSURL *url = [NSURL fileURLWithPath:str];
    NSLog(@"%@ \n\n%@\n\n", str, url);
    
    return [NSURL fileURLWithPath:str];
}

-(void)deleteSound {
    
    NSError *error;
    if (![[NSFileManager defaultManager] removeItemAtURL:self.audioURLOriginal error:&error])
		NSLog(@"Error Removing Original Audio: %@", [error localizedDescription]);

    if (![[NSFileManager defaultManager] removeItemAtURL:self.audioURLReversed error:&error])
		NSLog(@"Error Removing Reversed Audio: %@", [error localizedDescription]);
    [self deleteEntity];
    
}

@end
