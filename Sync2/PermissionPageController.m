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

@interface PermissionPageController ()

@property(nonatomic, strong) NSArray<UIViewController *> *vcDataSource;
@property(nonatomic, readwrite) NSInteger index;

@end

@implementation PermissionPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    WelcomeViewController *welcomeVC = (WelcomeViewController *)[self ViewControllerFromStoryboard:@"welcomeView"];
    welcomeVC.parentPageViewController = self;
    LocationPermissionViewController *locationVC = (LocationPermissionViewController *)[self ViewControllerFromStoryboard:@"locationView"];
    
    self.vcDataSource = @[welcomeVC,
                          locationVC];
    
    if (self.viewControllers.count == 0) {
        [self setViewControllers:@[self.vcDataSource[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

-(void)next{
    
    if (self.index+1 < self.vcDataSource.count) {
        self.index++;
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
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
