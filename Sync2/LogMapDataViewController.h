//
//  LogMapDataViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 05/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SixgillSDK;

@protocol LogMapDataDelegate

-(void) logsButtonTapped;

@end;

@interface LogMapDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *logsButton;
- (IBAction)logsButtonTapped:(id)sender;
@property (weak, nonatomic) Event *event;
@property (weak, nonatomic) NSString *buttonLabelText;
@property (nonatomic, weak) id<LogMapDataDelegate> delegate;
@end
