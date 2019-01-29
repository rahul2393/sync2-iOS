//
//  DefaultNotificationTableViewCell.h
//  Sync2
//
//  Created by Sanchit Mittal on 07/01/19.
//  Copyright © 2019 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SixgillSDK;

@interface DefaultNotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


-(void)configureCell:(Notification *)notification;
@end
