//
//  ProjectSelectionViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "ProjectSelectionViewController.h"
#import "DummyProjectData.h"
#import "Project.h"
#import "SettingsManager.h"
#import "ProjectSelectionTableViewCell.h"

@interface ProjectSelectionViewController ()
@property (nonatomic, readwrite) BOOL useDummy;
@property (nonatomic, readwrite) BOOL projectSelected;
@property (nonatomic, readwrite) NSInteger selectedIx;
@end

@implementation ProjectSelectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.accessibilityIdentifier = @"projectTable";
    self.tableView.accessibilityLabel = @"projectTable";
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectSelectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
    
    if (!self.projects) {
        
        self.useDummy = NO;
        
        if (self.useDummy) {
            self.projects = [DummyProjectData projects];
        }else{
            self.projects = [NSArray array];
        }
    }
    
    self.title = @"Select Project to Use";
    
    [self.selectProjectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.selectProjectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selectedIx = -1;
    [self setButtonEnabled:NO];
    
    if (!self.useDummy) {
        Project *selectedProject = [[SettingsManager sharedManager] selectedProject];
        if (selectedProject) {
            NSUInteger selectedIndex = [self.projects indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([[(Project *)obj objectId] isEqualToString:selectedProject.objectId]) {
                    *stop = YES;
                    return YES;
                }
                return NO;
            }];
            
            if (selectedIndex != NSNotFound) {
                self.projectSelected = YES;
                self.selectedIx = selectedIndex;
                [self setButtonEnabled:YES];
                
                UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTapped)];
                cancelItem.tintColor = [UIColor whiteColor];
                self.navigationItem.leftBarButtonItem = cancelItem;
            }
        }
    }
}

- (void)cancelTapped {
    [self dismissScreen];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectedIx == indexPath.row) {
        self.projectSelected = !self.projectSelected;
        self.selectedIx = -1;
        [self setButtonEnabled:NO];
    }else{
        self.projectSelected = YES;
        self.selectedIx = indexPath.row;
        [self setButtonEnabled:YES];
    }
    
    
    [self.tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.projects.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49.0;
}

-(void) setButtonEnabled:(BOOL)enabled{
    self.selectProjectButton.enabled = enabled;
}


-(UITableViewCell *) channelCellForIndexPath:(NSIndexPath *)indexPath{

    ProjectSelectionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
    
    if (!cell) {
        cell = [[ProjectSelectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
    }
    
    if (self.useDummy) {
        cell.cellSelectedImage.image = (self.selectedIx == indexPath.row && self.projectSelected) ? [UIImage imageNamed: @"selectedChannelCell"] : [UIImage imageNamed: @"deSelectedChannelCell"];
        cell.channelName.text = self.projects[indexPath.row];
        cell.platformName.text = @"";
    }else{
        Project *p = self.projects[indexPath.row];
        cell.cellSelectedImage.image = (self.selectedIx == indexPath.row && self.projectSelected) ? [UIImage imageNamed: @"selectedChannelCell"] : [UIImage imageNamed: @"deSelectedChannelCell"];
        cell.channelName.text = p.name;
        cell.platformName.text = @"";
    }
    
    return cell;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self channelCellForIndexPath:indexPath];
}


- (IBAction)selectProjectButtonTapped:(id)sender {
    
    [[SettingsManager sharedManager] selectProject:self.projects[self.selectedIx]];
    
    NSLog(@"Button tapped");
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

@end
