//
//  CameraPermissionViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/5/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "CameraPermissionViewController.h"

@interface CameraPermissionViewController ()

@end

@implementation CameraPermissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)enableCameraTapped:(id)sender {
    
    [self.parentPageViewController next];
}

- (IBAction)skipTapped:(id)sender {
    
    [self.parentPageViewController next];
}
@end
