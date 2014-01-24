//
//  SoundListCell.h
//  ynnuS
//
//  Created by Jason Garrett on 1/21/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoundListCell : UITableViewCell

@property (weak, nonatomic) id delegate;

@property (strong, nonatomic) Sound *soundModel;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end
