//
//  AccountsTableViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 5/28/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "AccountsTableViewController.h"
#import "SettingsManager.h"
@interface AccountsTableViewController ()

@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation AccountsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (!self.dataSource) {
        self.dataSource = @[@"Sixgill"];
    }
    
    if (self.dataSource.count != 0) {
        [self.noAccountsImageView setHidden:YES];
    }else{
        [self.noAccountsImageView setHidden:NO];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (![[SettingsManager sharedManager] hasOnboarded]) {
        [self performSegueWithIdentifier:@"showPermissionRequests" sender:self];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showAccountDetail" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

- (IBAction)addButtonTapped:(id)sender {
}

@end
