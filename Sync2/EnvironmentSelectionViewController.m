//
//  EnvironmentSelectionViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 3/5/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "EnvironmentSelectionViewController.h"
#import "TextViewTableViewCell.h"
#import "EnvironmentManager.h"
@interface EnvironmentSelectionViewController ()

@property (nonatomic, readwrite) BOOL environmentChanged;
@property (nonatomic, readwrite) NSInteger startingIx;
@property (nonatomic, readwrite) NSInteger selectedIx;
@end

@implementation EnvironmentSelectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.environments) {
                
        self.environments = [[EnvironmentManager sharedManager] environments];
    }
    
    self.title = @"Select Environment";
    
    [self.selectEnvironmentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.selectEnvironmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.startingIx = [[EnvironmentManager sharedManager] selectedEnvironment];
    self.selectedIx = self.startingIx;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setButtonEnabled:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return;
    }
    
    self.selectedIx = indexPath.row;
    [self.tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
        default:
            return self.environments.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(TextViewTableViewCell *) textCellForTableView:(UITableView *)tableView{
    TextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"environmentInfoCell"];
    
    if (cell == nil) {
        cell = [[TextViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"environmentInfoCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UITableViewCell *) descriptionCell{
    TextViewTableViewCell *cell = [self textCellForTableView:self.tableView];
    cell.label.text = @"Environments";
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 123.0;
    }else{
        return 44.0;
    }
    
}

-(void) setButtonEnabled:(BOOL)enabled{
    self.selectEnvironmentButton.enabled = enabled;
}


-(UITableViewCell *) envCellForIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[TextViewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Environment *env = self.environments[indexPath.row];
    
    cell.textLabel.text = env.name;
    
    if (self.selectedIx == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return [self descriptionCell];
        default:
            return [self envCellForIndexPath:indexPath];
    }
}

- (IBAction)selectEnvironmentButtonTapped:(id)sender {
    
    if (self.selectedIx == self.startingIx) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
               
            }];
        }
    }else{
//        [[EnvironmentManager sharedManager] setSelectedEnvironment:self.selectedIx];
        
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [self.settingsVC logout];
            }];
        }
    }
}


@end
