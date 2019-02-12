//
//  OrganizationSelectionViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 07/02/19.
//  Copyright © 2019 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrganizationSelectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *selectOrganizationButton;
@property (weak, nonatomic) IBOutlet UIView *noOrganizationView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@property (nonatomic, strong) NSArray *organizations;

- (IBAction)selectOrganizationButtonTapped:(UIButton *)sender;
@end
