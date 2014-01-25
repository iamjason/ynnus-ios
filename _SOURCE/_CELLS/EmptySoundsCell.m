//
//  EmptySoundsCell.m
//  ynnuS
//
//  Created by Jason Garrett on 1/17/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import "EmptySoundsCell.h"

@implementation EmptySoundsCell

-(void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor =
    self.contentView.backgroundColor = COLOR_VIEW_BACKGROUND;
}

@end
