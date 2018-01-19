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
@interface DataChannelSelectionViewController ()

@property (nonatomic, readwrite) NSInteger selectedChannelIx;
@property (nonatomic, readwrite) BOOL channelSelected;

@end

@implementation DataChannelSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.channels) {
        
        self.useDummy = YES;
        
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
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setButtonEnabled:NO];
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
    cell.textLabel.text = self.channels[indexPath.row];
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
    
    NSLog(@"Button tapped");
}
@end
