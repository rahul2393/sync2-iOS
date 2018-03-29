//
//  NotificationsTableViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "NotificationsTableViewController.h"
#import "DummyNotificationData.h"
#import "TextViewTableViewCell.h"
#import "TextNotification.h"
#import "SettingsManager.h"
@interface NotificationsTableViewController ()

@property (nonatomic, readwrite) BOOL useDummyData;
@property (nonatomic, strong) NSArray *notifications;

@end

@implementation NotificationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.useDummyData = NO;
    
    self.title = @"Notifications";

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.useDummyData) {
        self.notifications = [DummyNotificationData notifications];
    } else {
        [self update];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(update)
                                                 name:@"PushReceived"
                                               object:nil];
    
}

-(void) update{
    self.notifications = [[SettingsManager sharedManager] savedRemoteNotificationPayloads];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.notifications.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextViewTableViewCell *cell = (TextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"textNotificationCell" forIndexPath:indexPath];
    
    TextNotification *tn = (TextNotification *) self.notifications[indexPath.row];
    cell.label.text = tn.title;
    cell.textView.text = tn.body;
    cell.dateLabel.text = [tn displayableDate];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 176;
}

@end
