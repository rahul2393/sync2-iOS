//
//  MotionPermissionViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/5/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "MotionPermissionViewController.h"
#import "Device.h"
@interface MotionPermissionViewController ()
@property(nonatomic, strong) CMMotionActivityManager *motionActivityManager;
@end

@implementation MotionPermissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)enableMotionTapped:(id)sender {
    
    self.motionActivityManager = [[CMMotionActivityManager alloc]init];
    [self.motionActivityManager queryActivityStartingFromDate:[NSDate date] toDate:[NSDate date] toQueue:[NSOperationQueue mainQueue] withHandler:^(NSArray<CMMotionActivity *> * _Nullable activities, NSError * _Nullable error) {
        
        [self.parentPageViewController next];
        
    }];
}

- (IBAction)skipTapped:(id)sender {
    
    [self.parentPageViewController next];
}
@end
