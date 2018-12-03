//
//  ChooseMapViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 28/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "ChooseMapViewController.h"
#import "ChooseMapTableViewCell.h"

@interface ChooseMapViewController ()

@property (nonatomic, readwrite) NSInteger selectedChannelIx;
@end

@implementation ChooseMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    
    self.title = @"Choose Map";
    
    [self.selectMapButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.selectMapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setButtonEnabled:NO];
    
    self.selectedChannelIx = -1;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.floorMapNames.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseMapTableViewCellIdentifier"];
    
    if (cell == nil) {
        cell = [[ChooseMapTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChooseMapTableViewCellIdentifier"];
    }
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"World Map";
    } else {
        cell.nameLabel.text = self.floorMapNames[indexPath.row + 1];
    }
    
    cell.selectedImage.image = (self.selectedChannelIx == indexPath.row) ? [UIImage imageNamed: @"selectedChannelCell"] : [UIImage imageNamed: @"deSelectedChannelCell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.selectedChannelIx) {
        self.selectedChannelIx = -1;
        [self setButtonEnabled:NO];
    } else {
        self.selectedChannelIx = indexPath.row;
        [self setButtonEnabled:YES];
    }
    [self.tableView reloadData];
}

-(void) setButtonEnabled:(BOOL)enabled{
    self.selectMapButton.enabled = enabled;
    if (self.selectedChannelIx == 0) {
        [self.mapViewDelegate drawMapForId:@""];
    } else {
        [self.mapViewDelegate drawMapForId:self.floorMapIds[self.selectedChannelIx + 1]];
    }
}

@end
