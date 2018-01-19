//
//  TextViewTableViewCell.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/17/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *textCellId;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
