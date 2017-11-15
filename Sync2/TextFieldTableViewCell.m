//
//  TextFieldTableViewCell.m
//  Sync2
//
//  Created by Ricky Kirkendall on 9/6/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation TextFieldTableViewCell

-(void)setup{
    self.textField.delegate = self;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.delegate textCellWithId:self.textCellId didFinishEditing:textField.text];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

@end
