//
//  SurveyNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SurveyNotificationTableViewCell.h"
#import "OptionSurveyTableViewCell.h"

#define SURVEY_OPTION_CELL_HEIGHT 38

@interface SurveyNotificationTableViewCell ()

@property (nonatomic, strong) NSString *submitURL;
@property NSArray *data;
@property (nonatomic, strong) NSMutableArray *radioButtonChecked;

@end

@implementation SurveyNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.radioButtonChecked = [[NSMutableArray alloc] init];
}

- (void)configureCell:(Notification *)notification {
    self.titleLabel.text = notification.title;
    self.detailLabel.text = notification.body;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(notification.timestamp / 1000.0)]]];
    
    self.data = notification.optionsArray;
    [self.button setTitle:notification.buttonText forState:UIControlStateNormal];
    self.submitURL = notification.submitURL;
    
    for (id _ in notification.optionsArray) {
        [self.radioButtonChecked addObject:[NSNumber numberWithBool:FALSE]];
    }
    
    self.tableViewHeightConstraint.constant = self.data.count * SURVEY_OPTION_CELL_HEIGHT;
    [self.tableView reloadData];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sendTapped:(id)sender {
    
    // use submitURL and send request
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    OptionSurveyTableViewCell *cell = (OptionSurveyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"OptionSurveyTableViewCellIdentifier" forIndexPath:indexPath];
    Notification_Options *option = self.data[indexPath.row];
    cell.optionValueLabel.text = option.text;
    cell.selectedImageView.image = [[self.radioButtonChecked objectAtIndex:indexPath.row] boolValue] ? [UIImage imageNamed: @"radio-button-check"] : [UIImage imageNamed: @"radio-button-unselected"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 38;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[self.radioButtonChecked objectAtIndex:indexPath.row] boolValue] ? [self.radioButtonChecked replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:FALSE]] : [self.radioButtonChecked replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:TRUE]];
    [self.tableView reloadData];
}

@end
