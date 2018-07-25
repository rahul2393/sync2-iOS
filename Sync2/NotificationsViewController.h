//
//  NotificationsViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *noNotificationsView;
@property (weak, nonatomic) IBOutlet UIView *permissionMissingView;
- (IBAction)openDeviceSettings:(id)sender;

@end
