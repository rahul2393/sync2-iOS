//
//  ProjectSelectionTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 20/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "ProjectSelectionTableViewCell.h"

@implementation ProjectSelectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configureCell:(BOOL)selected name:(NSString*)name platform:(NSString*)platform {
    _cellSelectedImage.image = selected ? [UIImage imageNamed: @"selectedChannelCell"] : [UIImage imageNamed: @"deSelectedChannelCell"];
    _channelName.text = name;
    _platformName.text = platform;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
