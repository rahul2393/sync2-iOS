//
//  OrganizationSelectionViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 07/02/19.
//  Copyright © 2019 Sixgill. All rights reserved.
//

#import "OrganizationSelectionViewController.h"
#import "Organization.h"
#import "SettingsManager.h"
#import "ProjectSelectionTableViewCell.h"
#import "SnackbarView.h"
#import "SDKManager.h"

@interface OrganizationSelectionViewController ()
@property (nonatomic, readwrite) NSInteger selectedOrganizationIx;
@property (nonatomic, readwrite) BOOL organizationSelected;
@end

@implementation OrganizationSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectSelectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
    
    if (!self.organizations) {
        self.organizations = [NSArray new];
    }
    
    [self.selectOrganizationButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.selectOrganizationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selectedOrganizationIx = -1;
    self.selectOrganizationButton.enabled = NO;
    [self.loadingView setHidden:YES];
    
    Organization *selectedOrganization = [[SettingsManager sharedManager] selectedOrganization];
    if (selectedOrganization) {
        
        NSUInteger selectedIndex = [self.organizations indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[(Organization *)obj objectId] isEqualToString:selectedOrganization.objectId]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        if (selectedIndex != NSNotFound) {
            self.organizationSelected = YES;
            self.selectedOrganizationIx = selectedIndex;
            self.selectOrganizationButton.enabled = YES;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTapped)];
            cancelItem.tintColor = [UIColor whiteColor];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.organizations.count == 0) {
        [self.tableView setHidden:YES];
        [self.noOrganizationView setHidden:NO];
        [self.selectOrganizationButton setHidden:YES];
        
        [self showSnackBar];
    } else {
        [self.tableView setHidden:NO];
        [self.noOrganizationView setHidden:YES];
        [self.selectOrganizationButton setHidden:NO];
    }
}

- (void)cancelTapped {
    [self dismissScreen];
}

- (void)dismissScreen {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.organizations.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProjectSelectionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
    
    if (cell == nil) {
        cell = [[ProjectSelectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
    }
    
    Organization *o = self.organizations[indexPath.row];
    cell.channelName.text = o.name;
    cell.platformName.text = @"";
    
    cell.cellSelectedImage.image = (self.selectedOrganizationIx == indexPath.row  &&  self.organizationSelected) ? [UIImage imageNamed: @"selectedChannelCell"] : [UIImage imageNamed: @"deSelectedChannelCell"];
    
    return cell;
}

#pragma mark - Table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectedOrganizationIx == indexPath.row) {
        self.organizationSelected = !self.organizationSelected;
        self.selectedOrganizationIx = -1;
        self.selectOrganizationButton.enabled = NO;
    }else{
        self.organizationSelected = YES;
        self.selectedOrganizationIx = indexPath.row;
        self.selectOrganizationButton.enabled = YES;
    }
    
    [self.tableView reloadData];
    
}

- (IBAction)selectOrganizationButtonTapped:(UIButton *)sender {
    NSLog(@"Button tapped");
    [self.loadingView setHidden:NO];
    [self.loadingView startAnimating];
    [self.selectOrganizationButton setHidden:YES];
    
    [[SettingsManager sharedManager] selectOrganization:self.organizations[self.selectedOrganizationIx] withCompletionHandler:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(),^{
            if (!error) {
                [self dismissScreen];
            }
            [self.loadingView setHidden:YES];
            [self.loadingView stopAnimating];
            [self.selectOrganizationButton setHidden:NO];
        });
    }];
}

#pragma mark - Snackbar View

-(void) showSnackBar {
    
    [SnackbarView showSnackbar:@"Select Another Account" actionText:@"GO TO LOGIN" actionHandler:^{
        [[SettingsManager sharedManager] logout];
        [[SDKManager sharedManager] stopSDK];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
