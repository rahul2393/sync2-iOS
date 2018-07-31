//
//  LogViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController ()
@property (nonatomic, strong) NSString *logs;
@end

@implementation LogViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.commaSeperatedButtonTitles =@"Map, List";
        self.textColor = [UIColor whiteColor];
        self.selectorColor = [UIColor colorWithRed:0.3 green:0.86 blue:0.35 alpha:1];
        self.selectorTextColor = [UIColor colorWithRed:0.3 green:0.86 blue:0.35 alpha:1];
        self.currentPage = 0;
        
        self.viewControllerIdentifiers = [NSArray arrayWithObjects:@"LogMapViewControllerIdentifier", @"LogListViewControllerIdentifier", nil];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.logs = [[SDKManager sharedManager] logs];
}

@end
