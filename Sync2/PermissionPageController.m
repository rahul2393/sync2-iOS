//
//  PermissionPageController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 5/30/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "PermissionPageController.h"
#import "WelcomeViewController.h"
@interface PermissionPageController ()

@property(nonatomic, strong) NSArray<UIViewController *> *vcDataSource;

@end

@implementation PermissionPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    WelcomeViewController *welcomeVC = (WelcomeViewController *)[self ViewControllerFromStoryboard:@"welcomeView"];
    
    self.vcDataSource = @[welcomeVC];
    
    if (self.viewControllers.count == 0) {
        [self setViewControllers:@[self.vcDataSource[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    
}

-(UIViewController *)ViewControllerFromStoryboard:(NSString *)name{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:name];
}


@end
