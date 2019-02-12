//
//  SettingsTableViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)logoutTapped:(id)sender;
-(void) logout;
- (IBAction)forceSensorUpdateTapped:(UIButton *)sender;
- (IBAction)forceLocationUpdateTapped:(UIButton *)sender;

@end
