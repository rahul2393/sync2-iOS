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
#import "SenseAPI.h"
#import "SettingsManager.h"
#import "Rule.h"
#import "Device.h"

#define kCloudRulesStore @"kCloudRulesStore"

@interface RulesCloudViewController ()

@property (nonatomic, strong) NSArray *rules;
@property (nonatomic, readwrite) Project *currentProject;
@end

@implementation RulesCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rules = [[NSArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView setHidden:YES];
    [self.emptyView setHidden:NO];
    
    _currentProject = [[SettingsManager sharedManager] selectedProject];
    
    // Setting tableview constraints
    switch (UIDevice.currentDevice.screenType) {
        case iPhoneX:
        case iPhones_6Plus_6sPlus_7Plus_8Plus:
            self.tableViewHeightConstraint.constant = 589;
            self.emptyViewHeightConstraint.constant = 589;
            break;
        case iPhones_6_6s_7_8:
            self.tableViewHeightConstraint.constant = 501;
            self.emptyViewHeightConstraint.constant = 501;
            break;
        default:
            break;
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_currentProject || !_currentProject.objectId || [_currentProject.objectId isEqualToString:@""]) {
        return;
    }
    
    [[SenseAPI sharedManager] GetRulesForProject:_currentProject.objectId WithCompletion:^(NSArray *rules, NSError * _Nullable error) {
        
        self.rules = rules;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.rules.count == 0) {
                [self.tableView setHidden:YES];
                [self.emptyView setHidden:NO];
            } else {
                [self.tableView setHidden:NO];
                [self.emptyView setHidden:YES];
                [self.tableView reloadData];
            }
        });
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rules.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RulesTableViewCell *cell = (RulesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RulesTableViewCellIdentifier" forIndexPath:indexPath];
    
    Rule *rule = self.rules[indexPath.section];
    cell.titleLabel.text = rule.name;
    cell.detailLabel.text = rule.ruledescription;
    cell.actionCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)rule.actions.count];
    cell.conditionCountLabel.text = @"1";
    cell.statusImageView.image = rule.enabled ? [UIImage imageNamed: @"rules-green-circle"] : [UIImage imageNamed: @"rules-red-circle"];
    
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
