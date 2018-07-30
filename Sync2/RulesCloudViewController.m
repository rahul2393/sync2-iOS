//
//  RulesCloudViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "RulesCloudViewController.h"
#import "RulesTableViewCell.h"
#import "RulesInformationViewController.h"
@interface RulesCloudViewController ()

@property (nonatomic, strong) NSArray *rules;

@end

@implementation RulesCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    if (self.rules.count == 0) {
//        [self.tableView setHidden:YES];
//        [self.emptyView setHidden:NO];
//    } else {
        [self.tableView setHidden:NO];
        [self.emptyView setHidden:YES];
        [self.tableView reloadData];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RulesTableViewCell *cell = (RulesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RulesTableViewCellIdentifier" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0: {
            cell.titleLabel.text = @"Send Message on Entering office";
            cell.detailLabel.text = @"Send a notification when a person enters WeWork office building.";
            cell.conditionCountLabel.text = @"1";
            cell.actionCountLabel.text = @"1";
            cell.statusImageView.image = [UIImage imageNamed: @"rules-green-circle"];
            break;
        }
        case 1: {
            cell.titleLabel.text = @"WeWork Promotion";
            cell.detailLabel.text = @"Promo codes for extra conference room bookings.";
            cell.conditionCountLabel.text = @"2";
            cell.actionCountLabel.text = @"1";
            cell.statusImageView.image = [UIImage imageNamed: @"rules-red-circle"];
            break;
        }
        case 2: {
            cell.titleLabel.text = @"WeWork Halloween";
            cell.detailLabel.text = @"Send out message for candy and drinks at 2PM.";
            cell.conditionCountLabel.text = @"1";
            cell.actionCountLabel.text = @"1";
            cell.statusImageView.image = [UIImage imageNamed: @"rules-empty-circle"];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RulesInformationViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RulesInformationViewControllerIdentifier"];
    vc.currentPage = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
