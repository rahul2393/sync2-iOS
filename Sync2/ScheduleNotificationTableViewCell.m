//
//  ScheduleNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "ScheduleNotificationTableViewCell.h"
#import "ActionSheetPicker.h"

@interface ScheduleNotificationTableViewCell ()
@property (nonatomic, strong) NSString *submitURL;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, readwrite) NSDate *endDate;
@end

@implementation ScheduleNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCell:(ScheduleNotification *)notification {
    self.titleLabel.text = notification.title;
    self.detailLabel.text = notification.body;
    self.dateLabel.text = [notification displayableDate];
    
    [self.button setTitle:notification.buttonText forState:UIControlStateNormal];
    self.submitURL = notification.submitUrl;
    
    self.startDate = [NSDate dateWithTimeIntervalSince1970:(notification.startTimeStamp / 1000.0)];
    self.endDate = [NSDate dateWithTimeIntervalSince1970:(notification.endTimeStamp / 1000.0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)scheduleTapped:(id)sender {
}

- (IBAction)datePickerTapped:(id)sender {
    [ActionSheetDatePicker showPickerWithTitle:@"Pick Date and Time" datePickerMode:UIDatePickerModeDateAndTime selectedDate:[NSDate date] minimumDate:self.startDate maximumDate:self.endDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd"];
        self.calendarDateLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:selectedDate]];
        
        NSDateFormatter *dayTimeFormatter = [[NSDateFormatter alloc] init];
        [dayTimeFormatter setDateFormat:@"EEEE, h:mm a"];
        self.calendarDayTimeLabel.text = [NSString stringWithFormat:@"%@", [dayTimeFormatter stringFromDate:selectedDate]];
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:sender];

}
@end
