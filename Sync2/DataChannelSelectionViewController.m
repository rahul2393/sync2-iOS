//
//  DataChannelSelectionViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "DataChannelSelectionViewController.h"
#import "DummyChannelData.h"
#import "DataChannel.h"
#import "SettingsManager.h"
#import "ProjectSelectionTableViewCell.h"

@interface DataChannelSelectionViewController ()

@property (nonatomic, readwrite) NSInteger selectedChannelIx;
@property (nonatomic, readwrite) BOOL channelSelected;

@end

@implementation DataChannelSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.accessibilityIdentifier = @"channelTable";
    self.tableView.accessibilityLabel = @"channelTable";
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectSelectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
    
    if (!self.channels) {
        
        self.useDummy = NO;
        
        if (self.useDummy) {
            self.channels = [DummyChannelData channelTitles];
        }else{
            self.channels = [NSArray array];
        }
    }
    
    [self.selectChannelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.selectChannelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selectedChannelIx = -1;
    [self setButtonEnabled:NO];
    
    if (!self.useDummy) {
        DataChannel *selectedChannel = [[SettingsManager sharedManager] selectedDataChannel];
        if (selectedChannel) {
            NSUInteger selectedIndex = [self.channels indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([[(DataChannel *)obj objectId] isEqualToString:selectedChannel.objectId]) {
                    *stop = YES;
                    return YES;
                }
                return NO;
            }];

            if (selectedIndex != NSNotFound) {
                self.channelSelected = YES;
                self.selectedChannelIx = selectedIndex;
                [self setButtonEnabled:YES];
                
                UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTapped)];
                cancelItem.tintColor = [UIColor whiteColor];
                self.navigationItem.leftBarButtonItem = cancelItem;
            }
        }
    }
}

- (void)cancelTapped {
    [self dismissScreen];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.channels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self channelCellForIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectedChannelIx == indexPath.row) {
        self.channelSelected = !self.channelSelected;
        self.selectedChannelIx = -1;
        [self setButtonEnabled:NO];
    }else{
        self.channelSelected = YES;
        self.selectedChannelIx = indexPath.row;
        [self setButtonEnabled:YES];
    }
    
    [self.tableView reloadData];
    
}

-(void) setButtonEnabled:(BOOL)enabled{
    self.selectChannelButton.enabled = enabled;
}


-(UITableViewCell *) channelCellForIndexPath:(NSIndexPath *)indexPath{
    ProjectSelectionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
  
    if (cell == nil) {
        cell = [[ProjectSelectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
    }

    if (self.useDummy) {
        [cell configureCell:(self.selectedChannelIx == indexPath.row  &&  self.channelSelected) name:self.channels[indexPath.row] platform:@"IOS"];
    }else {
        DataChannel *dc = self.channels[indexPath.row];
        [cell configureCell:(self.selectedChannelIx == indexPath.row  &&  self.channelSelected) name:dc.name platform:@"IOS"];
    }
    
    return cell;
}

- (IBAction)selectChannelButtonTapped:(id)sender {
    
    [[SettingsManager sharedManager] selectDataChannel:self.channels[self.selectedChannelIx]];
    
    NSLog(@"Button tapped");
    
    [self dismissScreen];
}

- (void)dismissScreen {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

@end
