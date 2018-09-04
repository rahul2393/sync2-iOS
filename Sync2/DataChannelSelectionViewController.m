//
//  DataChannelSelectionViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "DataChannelSelectionViewController.h"
#import "DataChannel.h"
#import "SettingsManager.h"
#import "ProjectSelectionTableViewCell.h"
#import "MaterialSnackbar.h"

@interface DataChannelSelectionViewController ()

@property (nonatomic, readwrite) NSInteger selectedChannelIx;
@property (nonatomic, readwrite) BOOL channelSelected;
-(void) filterIOSChannels: (NSArray*) channels;
@property (nonatomic, readwrite) NSTimer *timer;
@end

@implementation DataChannelSelectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.accessibilityIdentifier = @"channelTable";
    self.tableView.accessibilityLabel = @"channelTable";
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectSelectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
    
    if (!self.channels) {
        self.channels = [NSArray array];
    }
    
    [self filterIOSChannels:self.channels];
    
    if (self.channels.count == 0) {
        [self.tableView setHidden:YES];
        [self.noChannelView setHidden:NO];
        [self.selectChannelButton setHidden:YES];
        
        
        MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
        message.text = @"Select Another Account";
        [message setDuration:10];
        
        MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
        void (^actionHandler)() = ^() {
            [[SettingsManager sharedManager] logout];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.timer invalidate];
            self.timer = nil;
        };
        action.handler = actionHandler;
        
        action.title = @"GO TO LOGIN";
        message.action = action;
        [MDCSnackbarManager showMessage:message];
        [MDCSnackbarManager setButtonTitleColor:[UIColor redColor] forState:UIControlStateNormal];

        self.timer = [NSTimer scheduledTimerWithTimeInterval: 10 target: self
                                       selector: @selector(handleTimer:) userInfo: message repeats: YES];
        
    } else {
        [self.tableView setHidden:NO];
        [self.noChannelView setHidden:YES];
        [self.selectChannelButton setHidden:NO];
    }
    
    [self.selectChannelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.selectChannelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selectedChannelIx = -1;
    [self setButtonEnabled:NO];
    
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

- (void)filterIOSChannels:(NSArray *)channels {
    NSPredicate *iosPredicate = [NSPredicate predicateWithFormat:@"SELF.type MATCHES[cd] %@",@"IOS"];
    self.channels = [self.channels filteredArrayUsingPredicate:iosPredicate];
}

- (void)cancelTapped {
    [self dismissScreen];
}

-(void) setButtonEnabled:(BOOL)enabled{
    self.selectChannelButton.enabled = enabled;
}

- (void)dismissScreen {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (void)handleTimer:(NSTimer*)theTimer {
    [MDCSnackbarManager showMessage:(MDCSnackbarMessage*)[theTimer userInfo]];
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.channels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProjectSelectionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
    
    if (cell == nil) {
        cell = [[ProjectSelectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProjectSelectionTableViewCellIdentifier"];
    }
    
    DataChannel *dc = self.channels[indexPath.row];
    cell.channelName.text = dc.name;
    cell.platformName.text = dc.type;
    
    cell.cellSelectedImage.image = (self.selectedChannelIx == indexPath.row  &&  self.channelSelected) ? [UIImage imageNamed: @"selectedChannelCell"] : [UIImage imageNamed: @"deSelectedChannelCell"];
    
    return cell;
}

#pragma mark - Table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49.0;
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

#pragma mark - IBAction

- (IBAction)selectChannelButtonTapped:(id)sender {
    
    [[SettingsManager sharedManager] selectDataChannel:self.channels[self.selectedChannelIx]];
    
    NSLog(@"Button tapped");
    
    [self dismissScreen];
}


@end
