//
//  WelcomeViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 5/25/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
- (IBAction)haveAccountTapped:(id)sender {
    [self.parentPageViewController next];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
