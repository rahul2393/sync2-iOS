//
//  RulesViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 26/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "RulesViewController.h"

#import "RulesEdgeViewController.h"
#import "RulesCloudViewController.h"

@interface RulesViewController ()

@end

@implementation RulesViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.commaSeperatedButtonTitles =@"Edge,Cloud";
        self.textColor = [UIColor whiteColor];
        self.selectorColor = [UIColor colorWithRed:0.3 green:0.86 blue:0.35 alpha:1];
        self.selectorTextColor = [UIColor colorWithRed:0.3 green:0.86 blue:0.35 alpha:1];
        self.currentPage = 0;
        
        
    }
    return self;
}

- (void)viewDidLoad{
    
    self.viewControllers = [[NSMutableArray alloc] init];
    
    RulesEdgeViewController *rulesEdgeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RulesEdgeViewControllerIdentifier"];
    [self.viewControllers addObject:rulesEdgeVC];
    
    RulesCloudViewController *rulesCloudVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RulesCloudViewControllerIdentifier"];
    [self.viewControllers addObject:rulesCloudVC];
    
    [super viewDidLoad];
}


@end
