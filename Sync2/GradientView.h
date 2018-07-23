//
//  GradientView.h
//  Sync2
//
//  Created by Sanchit Mittal on 23/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface GradientView : UIView

@property (nonatomic) IBInspectable UIColor* topColor;
@property (nonatomic) IBInspectable UIColor* bottomColor;

@property (nonatomic) IBInspectable CGPoint startPoint;
@property (nonatomic) IBInspectable CGPoint endPoint;

@property (nonatomic) IBInspectable NSInteger startLocation;
@property (nonatomic) IBInspectable NSInteger endLocation;

@property (nonatomic, strong) CAGradientLayer* gradientLayer;

@end
