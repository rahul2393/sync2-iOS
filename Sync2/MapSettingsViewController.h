//
//  MapSettingsViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/22/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchCell.h"
@interface MapSettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SwitchDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
