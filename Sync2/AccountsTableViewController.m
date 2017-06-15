//
//  AccountsTableViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 5/28/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "AccountsTableViewController.h"
#import "SettingsManager.h"
#import "AccountDetailTableViewController.h"

#define DEMO_API_KEY @"what hath God wrought?"

@interface AccountsTableViewController ()

@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic, strong) Account *selectedAccount;

@end

@implementation AccountsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    
    self.dataSource = [[SettingsManager sharedManager] accounts];
    
    if (!self.dataSource) {
        self.dataSource = @[];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (![[SettingsManager sharedManager] hasOnboarded]) {
        [self performSegueWithIdentifier:@"showPermissionRequests" sender:self];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataSource.count != 0) {
        [self.noAccountsImageView setHidden:YES];
    }else{
        [self.noAccountsImageView setHidden:NO];
    }
    
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Account *a = self.dataSource[indexPath.row];
    cell.textLabel.text = a.accountName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedAccount = self.dataSource[indexPath.row];
    [self performSegueWithIdentifier:@"showAccountDetail" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showAccountDetail"]) {
        AccountDetailTableViewController *detailVC = (AccountDetailTableViewController *)segue.destinationViewController;
        detailVC.accountObject = self.selectedAccount;
    }
}

- (IBAction)addButtonTapped:(id)sender {
    
    // Create the reader object
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // Instantiate the view controller
    QRCodeReaderViewController *vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:NO showTorchButton:NO];
    
    vc.delegate = self;
    
    // Set the presentation style
    self.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:vc animated:YES completion:NULL];
    
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    // Show user feedback based on valid qr code or not
    
    BOOL validQR = NO;
    BOOL alreadyUsed = NO;
    
    if ([result isEqualToString:DEMO_API_KEY]) {
        validQR = YES;
        // Check to see if demo account exists already
        BOOL exists = NO;
        for (Account *a in self.dataSource) {
            if ([a.accountId isEqualToString:@"demoAccount"]) {
                exists = YES;
                break;
            }
        }
        
        if (!exists) {
            
            Account *demoAccount = [[Account alloc]init];
            demoAccount.accountId = @"demoAccount";
            demoAccount.apiKey = result;
            demoAccount.accountName = @"Sixgill Demo";
            [[SettingsManager sharedManager] addAccount:demoAccount];
        }else{
            alreadyUsed = exists;
        }
        
        self.dataSource = [[SettingsManager sharedManager] accounts];
        
    }else{
        validQR = NO;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.tableView reloadData];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
