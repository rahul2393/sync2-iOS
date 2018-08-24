//
//  LogViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "LogViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface LogViewController ()
@end

@implementation LogViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.commaSeperatedButtonTitles =@"List, Map";
        self.textColor = [UIColor whiteColor];
        self.selectorColor = [UIColor colorWithRed:0.3 green:0.86 blue:0.35 alpha:1];
        self.selectorTextColor = [UIColor colorWithRed:0.3 green:0.86 blue:0.35 alpha:1];
        self.currentPage = 0;
        
        self.viewControllerIdentifiers = [NSArray arrayWithObjects:@"LogListViewControllerIdentifier", @"LogMapViewControllerIdentifier", nil];
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"fromDate"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"toDate"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CMMotionActivityManager* motionActivityManager = [[CMMotionActivityManager alloc]init];
    [motionActivityManager queryActivityStartingFromDate:[NSDate date] toDate:[NSDate date] toQueue:[NSOperationQueue mainQueue] withHandler:^(NSArray<CMMotionActivity *> * _Nullable activities, NSError * _Nullable error) {
        
    }];

}

@end
