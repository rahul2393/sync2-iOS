//
//  LogBaseViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 23/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogBaseViewController: UIViewController

@property NSDate *fromDate;
@property NSDate *toDate;
@property (nonatomic) NSArray *logs;
@property NSDateFormatter *dateLabelFormatter;

-(void) filterLogList;
-(void) datesSelected:(id)sender;

-(void) logsChanged;
-(void) updateDateLabel;
-(void) updateViewWithSensorData;


@end
