//
//  ProjectSelectionViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectSelectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *selectProjectButton;
@property (weak, nonatomic) IBOutlet UIView *noProjectView;

@property (nonatomic, strong) NSArray *projects;

- (IBAction)selectProjectButtonTapped:(id)sender;

@end
