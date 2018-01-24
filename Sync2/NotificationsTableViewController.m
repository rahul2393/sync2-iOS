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
@interface NotificationsTableViewController ()

@property (nonatomic, readwrite) BOOL useDummyData;
@property (nonatomic, strong) NSArray *notifications;

@end

@implementation NotificationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.useDummyData = YES;
    if (self.useDummyData) {
        self.notifications = [DummyNotificationData notifications];
    }else{
        self.notifications = @[];
    }
    
    self.title = @"Notifications";

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
