//
//  NotificationViewController.h
//  ScheduleNotificationContentExtension
//
//  Created by Sanchit Mittal on 30/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
