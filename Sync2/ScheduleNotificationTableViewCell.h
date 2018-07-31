//
//  ScheduleNotificationTableViewCell.h
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleNotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *subDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *calendarDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *calendarDayTimeLabel;
- (IBAction)scheduleTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end