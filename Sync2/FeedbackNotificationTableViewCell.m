//
//  FeedbackNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "FeedbackNotificationTableViewCell.h"

@interface FeedbackNotificationTableViewCell ()
@property (nonatomic, strong) NSString *submitURL;
@end

@implementation FeedbackNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.feedbackTextView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell{
    self.titleLabel.text = self.notification.title;
    self.detailLabel.text = self.notification.body;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(self.notification.timestamp / 1000.0)]]];
    
    self.feedbackTextView.placeholder = self.notification.hint;
    [self.button setTitle:self.notification.actionsArray[0].text forState:UIControlStateNormal];
    self.submitURL = self.notification.submitURL;
}

- (IBAction)sendFeedbackTapped:(id)sender {
    NSDictionary *body = @{ @"responseData": @{ @"value": self.feedbackTextView.text } };
    [[SGSDK sharedInstance] postNotificationFeedbackForNotification:self.notification withBody:[body mutableCopy] andSuccessHandler:^{
        
    } andFailureHandler:^(NSString *failureMsg) {
        
    }];
}

#pragma mark - UITextViewDelegate methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.feedbackTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
