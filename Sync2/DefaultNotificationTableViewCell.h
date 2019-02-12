//
//  DefaultNotificationTableViewCell.h
//  Sync2
//
//  Created by Sanchit Mittal on 05/02/19.
//  Copyright © 2019 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SixgillSDK;

@interface DefaultNotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

-(void)configureCell:(Notification *)notification;
@end
