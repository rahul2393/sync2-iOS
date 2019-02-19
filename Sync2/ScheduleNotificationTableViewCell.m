//
//  ScheduleNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "ScheduleNotificationTableViewCell.h"
#import "ActionSheetPicker.h"

#import "UIView+Toast.h"
#import "UIViewExtension.h"

@interface ScheduleNotificationTableViewCell ()
@property (nonatomic, strong) NSString *submitURL;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, readwrite) NSDate *endDate;
@property (nonatomic, readwrite) NSDate *selectedDate;
@end

@implementation ScheduleNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCell{
    self.titleLabel.text = self.notification.title;
    self.detailLabel.text = self.notification.body;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(self.notification.timestamp / 1000.0)]]];
    
    [self.button setTitle:self.notification.actionsArray[0].text forState:UIControlStateNormal];
    self.submitURL = self.notification.submitURL;
    
//    self.startDate = [NSDate dateWithTimeIntervalSince1970:(self.notification.startTimestamp / 1000.0)];
//    self.endDate = [NSDate dateWithTimeIntervalSince1970:(self.notification.endTimestamp / 1000.0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)scheduleTapped:(id)sender {
    NSDictionary *body = @{ @"responseData": @{ @"value": [NSNumber numberWithDouble:[self.selectedDate timeIntervalSince1970]] } };
    [[SGSDK sharedInstance] postNotificationFeedbackForNotification:self.notification withBody:[body mutableCopy] andSuccessHandler:^{
        [[self findViewController].view makeToast:self.notification.actionsArray[0].message];
    } andFailureHandler:^(NSString *failureMsg) {
        [[self findViewController].view makeToast:failureMsg];
    }];
}

- (IBAction)datePickerTapped:(id)sender {
    [ActionSheetDatePicker showPickerWithTitle:@"Pick Date and Time" datePickerMode:UIDatePickerModeDateAndTime selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd"];
        self.calendarDateLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:selectedDate]];
        
        NSDateFormatter *dayTimeFormatter = [[NSDateFormatter alloc] init];
        [dayTimeFormatter setDateFormat:@"EEEE, h:mm a"];
        self.calendarDayTimeLabel.text = [NSString stringWithFormat:@"%@", [dayTimeFormatter stringFromDate:selectedDate]];
        
        self.selectedDate = selectedDate;
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:sender];

}
@end
