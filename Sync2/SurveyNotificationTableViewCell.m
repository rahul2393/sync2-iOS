//
//  SurveyNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SurveyNotificationTableViewCell.h"
#import "OptionSurveyTableViewCell.h"

@interface SurveyNotificationTableViewCell ()

@property (nonatomic, strong) NSMutableArray *radioButtonChecked;

@end

@implementation SurveyNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.radioButtonChecked = [[NSMutableArray alloc] init];
    
    [self.radioButtonChecked addObject:[NSNumber numberWithBool:TRUE]];
    [self.radioButtonChecked addObject:[NSNumber numberWithBool:FALSE]];
    [self.radioButtonChecked addObject:[NSNumber numberWithBool:TRUE]];
    [self.radioButtonChecked addObject:[NSNumber numberWithBool:FALSE]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sendTapped:(id)sender {
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    OptionSurveyTableViewCell *cell = (OptionSurveyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"OptionSurveyTableViewCellIdentifier" forIndexPath:indexPath];
    cell.optionValueLabel.text = self.data[indexPath.row];
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
