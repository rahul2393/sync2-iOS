//
//  SettingsTableViewCell.h
//  Sync2
//
//  Created by Sanchit Mittal on 28/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CopyLabel.h"

@interface SettingsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet CopyLabel *valueLabel;

@end
