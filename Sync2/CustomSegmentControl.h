//
//  CustomSegmentControl.h
//  Sync2
//
//  Created by Sanchit Mittal on 26/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSegmentControl : UIControl

@property (nonatomic) NSString* commaSeperatedButtonTitles;
@property (nonatomic) UIColor* textColor;
@property (nonatomic) UIColor* selectorColor;
@property (nonatomic) UIColor* selectorTextColor;
@property (nonatomic, readwrite) NSInteger selectedSegmentIndex;
-(void) updateSegmentedControlSegs:(NSInteger)index;
@end
