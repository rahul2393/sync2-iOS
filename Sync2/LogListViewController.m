//
//  LogListViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 26/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "LogListViewController.h"

@interface LogListViewController ()
@property NSArray* logs;
@end

@implementation LogListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.logs = [[NSArray alloc] initWithObjects: @"1:10:00 PM, June 20, 2018", @"1:09:30 PM, June 20, 2018", @"1:09:00 PM, June 20, 2018", @"1:08:30 PM, June 20, 2018", @"1:08:00 PM, June 20, 2018", @"1:07:30 PM, June 20, 2018", @"1:07:00 PM, June 20, 2018", @"1:06:30 PM, June 20, 2018", nil] ;

    [self.tableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogListCellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.logs[indexPath.row];

    return cell;
}

@end
