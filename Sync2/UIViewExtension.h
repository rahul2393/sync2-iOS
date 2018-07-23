//
//  UIViewExtension.h
//  Sync2
//
//  Created by Sanchit Mittal on 23/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#ifndef UIViewExtension_h
#define UIViewExtension_h


#endif /* UIViewExtension_h */


#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (Test)

@property (nonatomic) IBInspectable UIColor* shadowColor;
@property (nonatomic) IBInspectable CGSize shadowOffset;
@property (nonatomic) IBInspectable CGFloat shadowOpacity;
@property (nonatomic) IBInspectable CGFloat shadowRadius;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end
