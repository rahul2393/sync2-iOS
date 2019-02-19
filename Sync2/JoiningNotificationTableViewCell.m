//
//  JoiningNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "JoiningNotificationTableViewCell.h"
#import "UIViewExtension.h"
#import "UIView+Toast.h"

@import SixgillSDK;

@interface JoiningNotificationTableViewCell ()
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, strong) NSString *submitURL;
@end


@implementation JoiningNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)configureCell{
    self.titleLabel.text = self.notification.title;
    self.detailLabel.text = self.notification.body;
    self.actionLabel.text = self.notification.hint;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(self.notification.timestamp / 1000.0)]]];
    
    self.submitURL = self.notification.submitURL;
    self.actions = self.notification.actionsArray;
    
    [self.notification.actionsArray enumerateObjectsUsingBlock:^(Notification_Actions* action, NSUInteger idx, BOOL *stop) {

        UIButton * btn = [self.actionButtons objectAtIndex:idx];
        [btn setTitle:action.text forState:UIControlStateNormal];

        if ([action.type isEqual: @"cancel"]) {

            [btn setTitleColor:[UIColor colorWithRed:1.0 green:0.11 blue:0.15 alpha:1] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
            btn.borderColor = [UIColor colorWithRed:1.0 green:0.11 blue:0.15 alpha:1];

        } else if ([action.type isEqual: @"success"]) {

            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithRed:0 green:0.32 blue:0.78 alpha:1];
            btn.borderColor = [UIColor colorWithRed:0 green:0.32 blue:0.78 alpha:1];

        }
    }];
}


- (IBAction)firstButtonTapped:(id)sender {
    NSDictionary *body = @{ @"responseData": @{ @"value": @"secondary" } };
    
    [[SGSDK sharedInstance] postNotificationFeedbackForNotification:self.notification withBody:[body mutableCopy] andSuccessHandler:^{
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.type contains[cd] %@",@"cancel"];
        Notification_Actions *a = [self.notification.actionsArray filteredArrayUsingPredicate:predicate].firstObject;
        [self.contentView.window.rootViewController.view makeToast:a.message];
        [[self findViewController].view makeToast:a.message];
        
    } andFailureHandler:^(NSString *failureMsg) {
        [[self findViewController].view makeToast:failureMsg];
    }];
}

- (IBAction)secondButtonTapped:(id)sender {
    NSDictionary *body = @{ @"responseData": @{ @"value": @"primary" } };
    [[SGSDK sharedInstance] postNotificationFeedbackForNotification:self.notification withBody:[body mutableCopy] andSuccessHandler:^{
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.type contains[cd] %@",@"success"];
        Notification_Actions *a = [self.notification.actionsArray filteredArrayUsingPredicate:predicate].firstObject;
        [[self findViewController].view makeToast:a.message];
        
    } andFailureHandler:^(NSString *failureMsg) {
        [[self findViewController].view makeToast:failureMsg];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
