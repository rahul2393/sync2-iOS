//
//  AccountsTableViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 5/28/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *noAccountsImageView;

- (IBAction)addButtonTapped:(id)sender;

@end
