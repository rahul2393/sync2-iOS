//
//  CustomSegmentControl.h
//  Sync2
//
//  Created by Sanchit Mittal on 26/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface CustomSegmentControl : UIControl

@property (nonatomic) IBInspectable NSString* commaSeperatedButtonTitles;
@property (nonatomic) IBInspectable UIColor* textColor;
@property (nonatomic) IBInspectable UIColor* selectorColor;
@property (nonatomic) IBInspectable UIColor* selectorTextColor;
-(void) updateSegmentedControlSegs:(int)index;
@end
