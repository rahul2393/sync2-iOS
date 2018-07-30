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
    self.selectedChannelIx = -1;
    [self setButtonEnabled:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseMapTableViewCellIdentifier"];
    
    if (cell == nil) {
        cell = [[ChooseMapTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChooseMapTableViewCellIdentifier"];
    }
    switch (indexPath.row) {
        case 0: {
            cell.nameLabel.text = @"World Map";
            break;
        }
        case 1: {
            cell.nameLabel.text = @"Office: Floor 1";
            break;
        }
        case 2: {
            cell.nameLabel.text = @"Office: Floor 2";
            break;
        }
        default:
            break;
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
}

@end
