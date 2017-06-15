//
//  AccountDetailTableViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchCell.h"
#import "Account.h"
@interface AccountDetailTableViewController : UITableViewController<SwitchDelegate>

@property (nonatomic, strong) Account *accountObject;

@end
