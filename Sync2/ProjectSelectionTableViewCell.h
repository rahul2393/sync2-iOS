//
//  ProjectSelectionTableViewCell.h
//  Sync2
//
//  Created by Sanchit Mittal on 20/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectSelectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellSelectedImage;
@property (weak, nonatomic) IBOutlet UILabel *channelName;
@property (weak, nonatomic) IBOutlet UILabel *platformName;

@end
