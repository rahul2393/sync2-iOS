//
//  JoiningNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "JoiningNotificationTableViewCell.h"
#import "UIViewExtension.h"

@interface JoiningNotificationTableViewCell ()
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, strong) NSString *submitURL;
@end


@implementation JoiningNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)configureCell:(Notification *)notification {
    self.titleLabel.text = notification.title;
    self.detailLabel.text = notification.body;
    self.actionLabel.text = notification.actionTitle;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(notification.timestamp / 1000.0)]]];
    
    self.submitURL = notification.submitURL;
    self.actions = notification.actionsArray;
    
    [notification.actionsArray enumerateObjectsUsingBlock:^(Notification_Actions* action, NSUInteger idx, BOOL *stop) {

        UIButton * btn = [self.actionButtons objectAtIndex:idx];
        [btn setTitle:action.text forState:UIControlStateNormal];

        if ([action.actionType isEqual: @"secondary"]) {

            [btn setTitleColor:[UIColor colorWithRed:1.0 green:0.11 blue:0.15 alpha:1] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
            btn.borderColor = [UIColor colorWithRed:1.0 green:0.11 blue:0.15 alpha:1];

        } else if ([action.actionType isEqual: @"primary"]) {

            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithRed:0 green:0.32 blue:0.78 alpha:1];
            btn.borderColor = [UIColor colorWithRed:0 green:0.32 blue:0.78 alpha:1];

        }
    }];
}


- (IBAction)firstButtonTapped:(id)sender {
    
}

- (IBAction)secondButtonTapped:(id)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
