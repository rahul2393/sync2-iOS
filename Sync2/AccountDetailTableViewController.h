//
//  AccountDetailTableViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchCell.h"
#import "TextFieldTableViewCell.h"
#import "Account.h"
#import "SDKManager.h"

@interface AccountDetailTableViewController : UITableViewController<SwitchDelegate, SensorUpdateDelegate, TextFieldCellDelegate>

@property (nonatomic, strong) Account *accountObject;

@end
