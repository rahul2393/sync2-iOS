//
//  FeedbackNotificationTableViewCell.h
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPlaceholderTextView.h"

@interface FeedbackNotificationTableViewCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *feedbackTextView;
- (IBAction)sendFeedbackTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
