//
//  AccountDetailTableViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "AccountDetailTableViewController.h"

@interface AccountDetailTableViewController ()
@property (nonatomic, strong) NSDictionary *dataSourceSectionData;
@property (nonatomic, strong) NSArray *dataSourceSectionLabels;
@end

@implementation AccountDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!self.dataSourceSectionLabels){
        self.dataSourceSectionLabels = @[@"",
                                         @"Data"];
    }
    
    
    if(!self.dataSourceSectionData){
        self.dataSourceSectionData = @{@"":@[@"Active Account"],
                                       @"Data": @[@"Location",
                                                  @"Cadence",
                                                  @"Wifi",
                                                  @"Battery",
                                                  @"Beacons In-Range",
                                                  @"Geofences",
                                                  @"Last update sent"]};
    }    
    
}

-(NSString *)cellTitleForIndexPath:(NSIndexPath *)indexPath{
    NSString *k = self.dataSourceSectionLabels[indexPath.section];
    NSArray *v = self.dataSourceSectionData[k];
    if (!v) {
        return @"";
    }
    
    return v[indexPath.row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSourceSectionLabels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *a = self.dataSourceSectionData[self.dataSourceSectionLabels[section]];
    
    if (a) {
        return a.count;
        
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
            if (cell == nil) {
                cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"switchCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
            break;
            
        default:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [self cellTitleForIndexPath:indexPath];
            
            return cell;
        }
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.dataSourceSectionLabels[section];
}

-(void)activeSwitchToggled:(BOOL)state{
    NSLog(@"Switch Toggled");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
