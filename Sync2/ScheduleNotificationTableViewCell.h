//
//  ScheduleNotificationTableViewCell.h
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@import SixgillSDK;

@interface ScheduleNotificationTableViewCell : UITableViewCell

@property (strong, nonatomic) Notification *notification;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *calendarDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *calendarDayTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)scheduleTapped:(id)sender;

- (IBAction)datePickerTapped:(id)sender;

-(void)configureCell;

@end
