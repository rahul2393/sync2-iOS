//
//  MasterTabViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "MasterTabViewController.h"
#import "SettingsManager.h"
#import "SenseAPI.h"
#import "DataChannelSelectionViewController.h"
#import "ProjectSelectionViewController.h"
@interface MasterTabViewController ()

@property (nonatomic, strong) NSArray *dataChannels;
@property (nonatomic, strong) NSArray *projects;

@end

@implementation MasterTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkCurrentAccountState];
}

-(void) checkCurrentAccountState{
    if (![[SettingsManager sharedManager] selectedProjectId]) {
        [self loadProjects];
    }else if (![[SettingsManager sharedManager] selectedDataChannelId]) {
        [self loadDataChannels];
    }
}

-(void) loadDataChannels{
    [[SenseAPI sharedManager] GetDataChannelsWithCompletion:^(NSArray *dataChannels, NSError * _Nullable error) {
        self.dataChannels = dataChannels;
        [self performSegueWithIdentifier:@"showDataChannelSelection" sender:self];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDataChannelSelection"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        DataChannelSelectionViewController *dcsvc = (DataChannelSelectionViewController *)nav.viewControllers[0];
        dcsvc.channels = self.dataChannels;
    }else if ([segue.identifier isEqualToString:@"showProjectSelection"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        ProjectSelectionViewController *vc = (ProjectSelectionViewController *)nav.viewControllers[0];
        vc.projects = self.projects;
    }
}

-(void) loadProjects{
    [[SenseAPI sharedManager] GetProjectsWithCompletion:^(NSArray *projects, NSError * _Nullable error) {
        self.projects = projects;
        [self performSegueWithIdentifier:@"showProjectSelection" sender:self];
    }];
}


@end
