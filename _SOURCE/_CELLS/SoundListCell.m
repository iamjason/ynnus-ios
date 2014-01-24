//
//  SoundListCell.m
//  ynnuS
//
//  Created by Jason Garrett on 1/21/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import "SoundListCell.h"

@implementation SoundListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSoundModel:(Sound *)soundModel {
    
    _soundModel = soundModel;
    
    self.nameLabel.text = _soundModel.name;
    self.dateLabel.text = [[CZDateFormatterCache mainThreadCache] localizedStringFromDate:_soundModel.created dateStyle:kCFDateFormatterShortStyle timeStyle:kCFDateFormatterShortStyle];
    
    [self layoutSubviews];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor =
    self.contentView.backgroundColor = VIEW_BACKGROUND_COLOR;
}
@end
