//
//  SurveyNotificationTableViewCell.h
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurveyNotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView; // cell height = 38
- (IBAction)sendTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
