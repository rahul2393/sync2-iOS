//
//  ScheduleNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "ScheduleNotificationTableViewCell.h"
#import "ActionSheetPicker.h"

@implementation ScheduleNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)scheduleTapped:(id)sender {
}

- (IBAction)datePickerTapped:(id)sender {
    
    [ActionSheetDatePicker showPickerWithTitle:@"Pick Date and Time" datePickerMode:UIDatePickerModeDateAndTime selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    }
                                        origin:sender];

}
@end
