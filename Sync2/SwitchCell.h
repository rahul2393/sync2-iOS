//
//  SwitchCell.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchDelegate

-(void)activeSwitchToggled:(BOOL)state withTag:(NSInteger)tag;

@end

@interface SwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *activeSwitch;
@property (nonatomic, weak) id<SwitchDelegate> delegate;

- (IBAction)activeSwitchToggled:(id)sender;

@end
