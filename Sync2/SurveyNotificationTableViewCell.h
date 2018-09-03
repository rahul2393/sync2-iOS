//
//  SurveyNotificationTableViewCell.h
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyNotification.h"

@interface SurveyNotificationTableViewCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView; // cell height = 38
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

- (IBAction)sendTapped:(id)sender;

-(void)configureCell:(SurveyNotification *)notification;

@end
