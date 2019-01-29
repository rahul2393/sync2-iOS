//
//  DefaultNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 07/01/19.
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

- (void)configureCell:(Notification *)notification{
    
    self.titleLabel.text = notification.subject;
    self.detailLabel.text = notification.message;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:notification.timestamp];
    self.dateLabel.text = [self displayableDateFor:date];

}

-(NSString *)displayableDateFor:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM dd, h:mm a"];
    
    return [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
}


@end
