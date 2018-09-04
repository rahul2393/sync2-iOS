//
//  ZoomControlView.m
//  Sync2
//
//  Created by Sanchit Mittal on 04/09/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "ZoomControlView.h"

@implementation ZoomControlView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self customInit];
    }
    return self;
}

-(void) customInit {
    
    [[NSBundle mainBundle] loadNibNamed:@"ZoomControlView" owner:self options:nil];
    
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}

- (IBAction)zoomIn:(id)sender {
    float zoomOutValue = self.mapView.camera.zoom + 1.0;
    [self.mapView animateToZoom:zoomOutValue];
}

- (IBAction)zoomOut:(id)sender {
    float zoomInValue = self.mapView.camera.zoom - 1.0;
    [self.mapView animateToZoom:zoomInValue];
}
@end
