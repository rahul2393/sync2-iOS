//
//  PermissionPageController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 5/30/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "PermissionPageController.h"
#import "WelcomeViewController.h"
#import "LocationPermissionViewController.h"
#import "MotionPermissionViewController.h"
#import "CameraPermissionViewController.h"
#import "PushPermissionViewController.h"
#import "SetupInfoViewController.h"
#import "SetupCompleteViewController.h"
#import "SettingsManager.h"

@interface PermissionPageController ()

@property(nonatomic, strong) NSArray<UIViewController *> *vcDataSource;
@property(nonatomic, readwrite) NSInteger index;

@end

@implementation PermissionPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[SettingsManager sharedManager] onBoardingIdx]) {
        [[SettingsManager sharedManager] setOnBoardingIdx:0];
    }
    
    self.index = [[SettingsManager sharedManager] onBoardingIdx];
    
//    WelcomeViewController *welcomeVC = (WelcomeViewController *)[self ViewControllerFromStoryboard:@"welcomeView"];
//    welcomeVC.parentPageViewController = self;
    
    SetupInfoViewController *setupInfoVC = (SetupInfoViewController *)[self ViewControllerFromStoryboard:@"setupInfoView"];
    setupInfoVC.parentPageViewController = self;
    
    LocationPermissionViewController *locationVC = (LocationPermissionViewController *)[self ViewControllerFromStoryboard:@"locationView"];
    locationVC.parentPageViewController = self;
    
    MotionPermissionViewController *motionVC = (MotionPermissionViewController *)[self ViewControllerFromStoryboard:@"motionActivityView"];
    motionVC.parentPageViewController = self;
    
    CameraPermissionViewController *cameraVC = (CameraPermissionViewController *)[self ViewControllerFromStoryboard:@"cameraAccessView"];
    cameraVC.parentPageViewController = self;
    
    PushPermissionViewController *pushVC = (PushPermissionViewController *)[self ViewControllerFromStoryboard:@"pushAccessView"];
    pushVC.parentPageViewController = self;
    
    SetupCompleteViewController *setupCompleteVC = (SetupCompleteViewController *)[self ViewControllerFromStoryboard:@"setupCompleteView"];
    setupCompleteVC.parentPageViewController = self;

    
    self.vcDataSource = @[setupInfoVC,
                          locationVC,
                          motionVC,
                          cameraVC,
                          pushVC,
                          setupCompleteVC];
    
    if (self.viewControllers.count == 0) {
        [self setViewControllers:@[self.vcDataSource[self.index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

-(void)next{
    
    if (self.index+1 < self.vcDataSource.count) {
        self.index++;
        [[SettingsManager sharedManager] setOnBoardingIdx:self.index];
    }else{
        [[SettingsManager sharedManager] setHasOnboarded:YES];
        return;
    }
    
    NSArray *a = @[self.vcDataSource[self.index]];        
    
    [self setViewControllers:a direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(UIViewController *)ViewControllerFromStoryboard:(NSString *)name{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:name];
}


@end
