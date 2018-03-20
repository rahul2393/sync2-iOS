//
//  DataChannelSelectionViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "DataChannelSelectionViewController.h"
#import "DummyChannelData.h"
#import "TextViewTableViewCell.h"
#import "DataChannel.h"
#import "SettingsManager.h"
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
    
    if (!self.channels) {
        
        self.useDummy = NO;
        
        if (self.useDummy) {
            self.channels = [DummyChannelData channelTitles];
        }else{
            self.channels = [NSArray array];
        }
    }
    
    self.title = @"Select Data Channel to Use";
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return;
    }
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
        default:
            return self.channels.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(TextViewTableViewCell *) textCellForTableView:(UITableView *)tableView{
    TextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataChannelInfoCell"];
    
    if (cell == nil) {
        cell = [[TextViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dataChannelInfoCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UITableViewCell *) descriptionCell{
    TextViewTableViewCell *cell = [self textCellForTableView:self.tableView];
    cell.label.text = @"Data Channels";
    cell.textView.text = [DummyChannelData descriptionText];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 176.0;
    }else{
        return 44.0;
    }
    
}

-(void) setButtonEnabled:(BOOL)enabled{
    self.selectChannelButton.enabled = enabled;
}


-(UITableViewCell *) channelCellForIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[TextViewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.useDummy) {
        cell.textLabel.text = self.channels[indexPath.row];
    }else{
        DataChannel *dc = self.channels[indexPath.row];
        cell.textLabel.text = dc.name;
    }
    
    cell.detailTextLabel.text = @"iOS";
    
    if (self.selectedChannelIx == indexPath.row && self.channelSelected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return [self descriptionCell];
        default:
            return [self channelCellForIndexPath:indexPath];
    }
    
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
