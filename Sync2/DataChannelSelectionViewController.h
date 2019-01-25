//
//  DataChannelSelectionViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataChannelSelectionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *selectChannelButton;
@property (weak, nonatomic) IBOutlet UIView *noChannelView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@property (nonatomic, readwrite) BOOL shouldFilterHailerType;

@property (nonatomic, strong) NSArray *channels;
@property (nonatomic, readwrite) BOOL useDummy;

- (IBAction)selectChannelButtonTapped:(id)sender;

@end
