//
//  WelcomeNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "WelcomeNotificationTableViewCell.h"

@implementation WelcomeNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(InformationNotification *)notification {
    self.titleLabel.text = notification.title;
    self.detailLabel.text = notification.body;
    self.dateLabel.text = [notification displayableDate];
}

@end
