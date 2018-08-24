//
//  LogBaseViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 23/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogBaseViewController: UIViewController

@property (nonatomic) NSDate *fromDate;
@property (nonatomic) NSDate *toDate;
@property (nonatomic) NSArray *logs;
@property NSDateFormatter *dateLabelFormatter;

-(void) filterLogList;
-(void) datesSelected:(id)sender onSuccessHandler:(void (^)())onSuccessBlock;

-(void) logsChanged;
-(void) updateDateLabel;
-(void) updateViewWithSensorData;


@end
