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
    
    self.titleLabel.text = @"";
    self.detailLabel.text = notification.message;
    self.dateLabel.text = [self displayableDateFor:notification.timestamp];

}

-(NSString *)displayableDateFor:(NSString *)timestamp{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS Z zzz"];
    NSDate *d = [dateFormatter dateFromString:timestamp];
    
    [dateFormatter setDateFormat:@"MMMM dd, h:mm a"];
    
    return [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:d]];
}


@end
