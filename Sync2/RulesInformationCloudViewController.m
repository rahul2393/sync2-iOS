//
//  RulesInformationCloudViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 30/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "RulesInformationCloudViewController.h"
#import "Device.h"

@interface RuleTableViewUtil : NSObject
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, readwrite) NSInteger indentationLevel;
@end

@implementation RuleTableViewUtil
@end

@interface RulesInformationCloudViewController ()
@property (nonatomic, retain) NSMutableArray<RuleTableViewUtil *> *conditionsArray;
@property (nonatomic, retain) NSMutableArray<RuleTableViewUtil *> *actionsArray;
@property (nonatomic, retain) NSArray<NSString *> *weekDays;
@end

@implementation RulesInformationCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        
    self.titleLabel.text = self.rule.name;
    self.detailLabel.text = self.rule.ruledescription;
    self.statusImageView.image = self.rule.enabled ? [UIImage imageNamed: @"rules-green-circle"] : [UIImage imageNamed: @"rules-red-circle"];

    self.conditionsArray = [NSMutableArray new];
    self.actionsArray = [NSMutableArray new];
    self.weekDays = [NSArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
    [self makeActionsObject:self.rule.actions andIndendation:1];
    [self makeConditionsObject:self.rule.conditionsObject andIndendation:1];
    [self.tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(10, 4, tableView.frame.size.width-20, 43)];
    labelView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:labelView.frame];
    [label setFont:[UIFont systemFontOfSize:14]];
    
    switch (section) {
        case 0:
            label.text = @"Rule Condition";
            break;
        case 1:
            label.text = @"Rule Action";
            break;
        case 2:
            label.text = @"Triggering Behavior";
            break;
        case 3:
            label.text = @"Tags";
            break;
        default:
            break;
    }
    
    [labelView addSubview:label];
    
    return labelView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 43;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.conditionsArray.count;
        case 1:
            return self.actionsArray.count;
        case 2:
            return 1;
        case 3:
            return self.rule.tags.count;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"RulesInformationCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
//    [cell setIndentationLevel:1];
    
    switch (indexPath.section) {
        case 0: {
            cell.textLabel.text = self.conditionsArray[indexPath.row].key;
            cell.detailTextLabel.text = self.conditionsArray[indexPath.row].value;
//            [cell setIndentationLevel:self.conditionsArray[indexPath.row].indentationLevel];  // change indentationWidth from srorybord currently it's 0 set as 10 or 20
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 1: {
            cell.textLabel.text = self.actionsArray[indexPath.row].key;
            cell.detailTextLabel.text = self.actionsArray[indexPath.row].value;
            break;
        }
        case 2: {
            cell.textLabel.text = @"Trigger";
            cell.detailTextLabel.text = @"9:00 AM, January 1, 2017";
            break;
        }
        case 3: {
            cell.detailTextLabel.text = self.rule.tags[indexPath.row];
            cell.textLabel.text = @"";
            break;
        }
        default:
            break;
    }
    
    return cell;
}

-(void) makeActionsObject:(NSArray<SGRuleAction *> *)ruleActions andIndendation:(NSInteger )level {
    for (SGRuleAction *ruleAction in ruleActions) {
        
        RuleTableViewUtil *rC = [[RuleTableViewUtil alloc] init];
        rC.key = @"Type";
        rC.value = ruleAction.type;
        rC.indentationLevel = level;
        [self.actionsArray addObject:rC];
        
        if ([ruleAction.type isEqualToString:@"email"] || [ruleAction.type isEqualToString:@"push"]) {
            
            RuleTableViewUtil *rC1 = [[RuleTableViewUtil alloc] init];
            rC1.key = @"Subject";
            rC1.value = ruleAction.subject;
            rC1.indentationLevel = level;
            [self.actionsArray addObject:rC1];
            
            RuleTableViewUtil *rC2 = [[RuleTableViewUtil alloc] init];
            rC2.key = @"Message";
            rC2.value = ruleAction.message;
            rC2.indentationLevel = level;
            [self.actionsArray addObject:rC2];
            
            RuleTableViewUtil *rC3 = [[RuleTableViewUtil alloc] init];
            rC3.key = @"Recipients";
            if (ruleAction.reflect) {
                rC3.value = @"All devices";
            } else {
                rC3.value = [NSString stringWithFormat:@"%lu devices", ruleAction.recipients.count];
            }
            rC3.indentationLevel = level;
            [self.actionsArray addObject:rC3];
            
        } else if ([ruleAction.type isEqualToString:@"sms"]) {
            
            RuleTableViewUtil *rC1 = [[RuleTableViewUtil alloc] init];
            rC1.key = @"Message";
            rC1.value = ruleAction.message;
            rC1.indentationLevel = level;
            [self.actionsArray addObject:rC1];
            
            RuleTableViewUtil *rC2 = [[RuleTableViewUtil alloc] init];
            rC2.key = @"Recipients";
            rC2.value = [NSString stringWithFormat:@"%lu devices", ruleAction.recipients.count];
            rC2.indentationLevel = level;
            [self.actionsArray addObject:rC2];
            
        } else if ([ruleAction.type isEqualToString:@"webhook"]) {
            RuleTableViewUtil *rC1 = [[RuleTableViewUtil alloc] init];
            rC1.key = @"URL";
            rC1.value = ruleAction.url;
            rC1.indentationLevel = level;
            [self.actionsArray addObject:rC1];
            
            RuleTableViewUtil *rC2 = [[RuleTableViewUtil alloc] init];
            rC2.key = @"Body";
            rC2.value = ruleAction.body;
            rC2.indentationLevel = level;
            [self.actionsArray addObject:rC2];
            
            RuleTableViewUtil *rC3 = [[RuleTableViewUtil alloc] init];
            rC3.key = @"Method";
            rC3.value = ruleAction.method;
            rC3.indentationLevel = level;
            [self.actionsArray addObject:rC3];
            
            for (NSString *key in ruleAction.headers) {
                RuleTableViewUtil *r = [[RuleTableViewUtil alloc] init];
                r.key = key;
                r.value = ruleAction.headers[key];
                r.indentationLevel = level;
                [self.actionsArray addObject:r];
            }
            
            RuleTableViewUtil *rC4 = [[RuleTableViewUtil alloc] init];
            rC4.key = @"Username";
            rC4.value = ruleAction.username;
            rC4.indentationLevel = level;
            [self.actionsArray addObject:rC4];
            
            RuleTableViewUtil *rC5 = [[RuleTableViewUtil alloc] init];
            rC5.key = @"Password";
            rC5.value = ruleAction.password;
            rC5.indentationLevel = level;
            [self.actionsArray addObject:rC5];
        }
    }
}

-(void) makeConditionsObject:(NSArray<SGRuleCondition *> *)ruleConditions andIndendation:(NSInteger )level {
    
    for (SGRuleCondition *ruleCondition in ruleConditions) {
        
        if (ruleCondition.items.count == 0) {
            
            RuleTableViewUtil *rC = [[RuleTableViewUtil alloc] init];
            rC.key = @"Type";
            rC.value = ruleCondition.type;
            rC.indentationLevel = level;
            [self.conditionsArray addObject:rC];
            
            if ([ruleCondition.type isEqualToString:@"schedule"]) {
                
                RuleTableViewUtil *rC1 = [[RuleTableViewUtil alloc] init];
                rC1.key = @"Timezone";
                rC1.value = ruleCondition.timezone;
                rC1.indentationLevel = level;
                [self.conditionsArray addObject:rC1];
                
                RuleTableViewUtil *rC2 = [[RuleTableViewUtil alloc] init];
                rC2.key = @"Start Date";
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd-MM-yyyy"];
                
                rC2.value = [dateFormatter stringFromDate:ruleCondition.scheduleFromDate];
                rC2.indentationLevel = level;
                [self.conditionsArray addObject:rC2];
                
                RuleTableViewUtil *rC3 = [[RuleTableViewUtil alloc] init];
                rC3.key = @"End Date";
                rC3.value = [dateFormatter stringFromDate:ruleCondition.scheduleToDate];
                rC3.indentationLevel = level;
                [self.conditionsArray addObject:rC3];
                
                RuleTableViewUtil *rC4 = [[RuleTableViewUtil alloc] init];
                rC4.key = @"Weekdays";
                NSString *output = [NSString new];
                for (NSNumber *day in ruleCondition.weekDays) {
                    output = [output stringByAppendingFormat:@"%@ ",[self.weekDays objectAtIndex:[day integerValue]]];
                }
                rC4.value = output;
                rC4.indentationLevel = level;
                [self.conditionsArray addObject:rC4];
                
                RuleTableViewUtil *rC5 = [[RuleTableViewUtil alloc] init];
                rC5.key = @"Start Hour";
                rC5.value = [NSString stringWithFormat:@"%02d:%02d", [ruleCondition.scheduleFromMinutes intValue]/60, [ruleCondition.scheduleFromMinutes intValue]%60];
                rC5.indentationLevel = level;
                [self.conditionsArray addObject:rC5];
                
                RuleTableViewUtil *rC6 = [[RuleTableViewUtil alloc] init];
                rC6.key = @"End Hour";
                rC6.value = [NSString stringWithFormat:@"%02d:%02d", [ruleCondition.scheduleToMinutes intValue]/60, [ruleCondition.scheduleToMinutes intValue]%60];
                rC6.indentationLevel = level;
                [self.conditionsArray addObject:rC6];
                
            } else if ([ruleCondition.type isEqualToString:@"landmark"]) {
                
                RuleTableViewUtil *rC1 = [[RuleTableViewUtil alloc] init];
                rC1.indentationLevel = level;
                rC1.key = @"Landmark Id";
                rC1.value = ruleCondition.ids.firstObject;
                [self.conditionsArray addObject:rC1];
                
                RuleTableViewUtil *rC2 = [[RuleTableViewUtil alloc] init];
                rC2.key = @"Trigger";
                rC2.value = ruleCondition.trigger;
                rC2.indentationLevel = level;
                [self.conditionsArray addObject:rC2];
                
                RuleTableViewUtil *rC3 = [[RuleTableViewUtil alloc] init];
                rC3.key = @"Attribute";
                rC3.value = ruleCondition.attribute;
                rC3.indentationLevel = level;
                [self.conditionsArray addObject:rC3];
                
            } else if ([ruleCondition.type isEqualToString:@"attribute"]) {
                
                RuleTableViewUtil *rC1 = [[RuleTableViewUtil alloc] init];
                rC1.key = @"Attribute";
                rC1.value = ruleCondition.attribute;
                rC1.indentationLevel = level;
                [self.conditionsArray addObject:rC1];
                
                RuleTableViewUtil *rC2 = [[RuleTableViewUtil alloc] init];
                rC2.key = @"Operator";
                rC2.value = ruleCondition.operator;
                rC2.indentationLevel = level;
                [self.conditionsArray addObject:rC2];
                
                RuleTableViewUtil *rC3 = [[RuleTableViewUtil alloc] init];
                rC3.key = @"Value";
                rC3.value = [ruleCondition.value stringValue];
                rC3.indentationLevel = level;
                [self.conditionsArray addObject:rC3];
                
            }
        } else {
            RuleTableViewUtil *rC = [[RuleTableViewUtil alloc] init];
            rC.key = @"Operator";
            rC.value = ruleCondition.type;
            rC.indentationLevel = level;
            [self.conditionsArray addObject:rC];
            [self makeConditionsObject:ruleCondition.items andIndendation:level+1];
            
        }
    }
}

@end
