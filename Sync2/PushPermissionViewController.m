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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)enablePushTapped:(id)sender {
    
    [self.parentPageViewController next];
}

- (IBAction)skipTapped:(id)sender {
    
    [self.parentPageViewController next];
}
@end
