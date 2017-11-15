//
//  TextFieldTableViewCell.h
//  Sync2
//
//  Created by Ricky Kirkendall on 9/6/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextFieldCellDelegate <NSObject>

-(void)textCellWithId:(NSString *)cellId didFinishEditing:(NSString *)text;

@end

@interface TextFieldTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, strong) NSString *textCellId;
@property (nonatomic, weak) id<TextFieldCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

-(void)setup;

@end
