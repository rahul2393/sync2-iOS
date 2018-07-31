//
//  RulesInformationViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 30/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "RulesInformationViewController.h"

@interface RulesInformationViewController ()

@end

@implementation RulesInformationViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.commaSeperatedButtonTitles =@"Edge,Cloud";
        self.textColor = [UIColor whiteColor];
        self.selectorColor = [UIColor colorWithRed:0.3 green:0.86 blue:0.35 alpha:1];
        self.selectorTextColor = [UIColor colorWithRed:0.3 green:0.86 blue:0.35 alpha:1];
        self.currentPage = 0;
        
        self.viewControllerIdentifiers = [NSArray arrayWithObjects:@"RulesInformationEdgeViewControllerIdentifier", @"RulesInformationCloudViewControllerIdentifier", nil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Rule Information";
    
//    self.segmentView.selectedSegmentIndex = self.currentPage;
    
    
}
@end
