//
//  LogMapDataViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 05/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogMapDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) NSDictionary *event;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)viewSDKLogsTapped:(id)sender;
@end
