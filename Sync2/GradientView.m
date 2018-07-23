//
//  GradientView.m
//  Sync2
//
//  Created by Sanchit Mittal on 23/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GradientView.h"

@implementation GradientView

-(void) setTopColor:(UIColor *)topColor {
    _topColor = topColor;
    [self setNeedsLayout];
}

-(void) setBottomColor:(UIColor *)bottomColor {
    _bottomColor = bottomColor;
    [self setNeedsLayout];
}

-(void) setStartPoint:(CGPoint)startPoint {
    _startPoint = startPoint;
    [self setNeedsLayout];
}

-(void) setEndPoint:(CGPoint)endPoint {
    _endPoint = endPoint;
    [self setNeedsLayout];
}

-(void) setStartLocation:(NSInteger)startLocation {
    _startLocation = startLocation;
    [self setNeedsLayout];
}

-(void) setEndLocation:(NSInteger)endLocation {
    _endLocation = endLocation;
    [self setNeedsLayout];
}

-(void) layoutSubviews {
    [super layoutSubviews];

    if (self.layer == nil) {
        self.gradientLayer = [[CAGradientLayer alloc] init];
    } else {
        self.gradientLayer = [[CAGradientLayer alloc] initWithLayer:self.layer];
    }
    _gradientLayer.frame = self.bounds;
    
    self.gradientLayer.colors = @[(id)_topColor.CGColor, (id)_bottomColor.CGColor];
    self.gradientLayer.locations = @[(id)[NSNumber numberWithLong: _startLocation], (id)[NSNumber numberWithLong:_endLocation]];
    self.gradientLayer.startPoint = _startPoint;
    self.gradientLayer.endPoint = _endPoint;
    
    [self.layer insertSublayer:_gradientLayer atIndex:0];
}

+ (Class)layerClass {
    return CAGradientLayer.self;
}

@end
