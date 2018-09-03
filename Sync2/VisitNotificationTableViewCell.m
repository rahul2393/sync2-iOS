//
//  VisitNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "VisitNotificationTableViewCell.h"

@implementation VisitNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mapView.delegate = self;
    // Initialization code
}

- (void)configureCell:(EventNotification *)notification {
    
    self.titleLabel.text = notification.title;
    self.detailLabel.text = notification.body;
    self.dateLabel.text = [notification displayableDate];
    
    self.address1Label.text = notification.addressTitle;
    self.address2Label.text = notification.address;
    
//    @property (weak, nonatomic) IBOutlet MKMapView *mapView;
//
//    "latitude" : 34.0161307,
//    "longitude": -118.4939754,
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
