//
//  EnvironmentSelectionViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 3/5/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Environment.h"
@interface EnvironmentSelectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *selectEnvironmentButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *environments;


@end
