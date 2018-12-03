//
//  ChooseMapViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 28/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface ChooseMapViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *selectMapButton;

@property (nonatomic, strong) NSMutableArray <NSString *> *floorMapNames;
@property (nonatomic, strong) NSMutableArray <NSString *> *floorMapIds;
@property (nonatomic, weak) id<MapViewDelegate> mapViewDelegate;
@end
