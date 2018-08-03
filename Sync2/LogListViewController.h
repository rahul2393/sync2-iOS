//
//  LogListViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 26/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)selectDateTapped:(id)sender;

@end
