//
//  PushPermissionViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/5/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "PushPermissionViewController.h"

@interface PushPermissionViewController ()

@end

@implementation PushPermissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(permissionChanged)
                                                 name:@"PushPermissionChanged"
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)permissionChanged{
    [self.parentPageViewController next];
}

- (IBAction)enablePushTapped:(id)sender {
    
    [self requestPushPermissions];
}

- (IBAction)skipTapped:(id)sender {
    
    [self.parentPageViewController next];
}

-(void)requestPushPermissions {
    UIUserNotificationSettings *settings =
    [UIUserNotificationSettings
     settingsForTypes: UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound
     categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

@end
