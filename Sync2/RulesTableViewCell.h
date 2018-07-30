//
//  RulesTableViewCell.h
//  Sync2
//
//  Created by Sanchit Mittal on 27/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RulesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionCountLabel;

@end
