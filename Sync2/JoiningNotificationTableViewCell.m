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

- (void)configureCell:(ActionNotification *)notification {
    self.titleLabel.text = notification.title;
    self.detailLabel.text = notification.body;
    self.actionLabel.text = notification.actionTitle;
    self.dateLabel.text = [notification displayableDate];
    self.submitURL = notification.submitUrl;
    self.actions = notification.actions;
    
    [notification.actions enumerateObjectsUsingBlock:^(Action* action, NSUInteger idx, BOOL *stop) {

        UIButton * btn = [self.actionButtons objectAtIndex:idx];
        [btn setTitle:action.text forState:UIControlStateNormal];

        if ([action.type isEqual: @"secondary"]) {

            [btn setTitleColor:[UIColor colorWithRed:1.0 green:0.11 blue:0.15 alpha:1] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
            btn.borderColor = [UIColor colorWithRed:1.0 green:0.11 blue:0.15 alpha:1];

        } else if ([action.type isEqual: @"primary"]) {

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
