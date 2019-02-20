//
//  DefaultNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 05/02/19.
//  Copyright © 2019 Sixgill. All rights reserved.
//

#import "DefaultNotificationTableViewCell.h"

@implementation DefaultNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell{
    self.titleLabel.text = self.notification.subject;
    self.detailLabel.text = self.notification.message;
    
}

@end
