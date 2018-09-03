//
//  JoiningNotificationTableViewCell.h
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionNotification.h"

@interface JoiningNotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *actionButtons;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)firstButtonTapped:(id)sender;

- (IBAction)secondButtonTapped:(id)sender;

-(void)configureCell:(ActionNotification *)notification;

@end
