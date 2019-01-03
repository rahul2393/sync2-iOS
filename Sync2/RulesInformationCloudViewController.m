//
//  RulesInformationCloudViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 30/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "RulesInformationCloudViewController.h"
#import "Device.h"
#import "RuleCondition.h"

@interface RulesInformationCloudViewController ()
@property (nonatomic, retain) NSMutableArray<RuleCondition *> *conditionsArray;
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
    [self makeConditionsObject:self.rule.conditionsObject andIndendation:1];
    [self.tableView reloadData];
}

- (IBAction)triggerRuleTapped:(id)sender {
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
            label.text = @"Schedule";
            break;
        case 3:
            label.text = @"Triggering Behavior";
            break;
        case 4:
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
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.conditionsArray.count;
        case 1:
            return self.rule.actions.count * 4;
        case 2:
            return 2;
        case 3:
            return 1;
        case 4:
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
    [cell setIndentationLevel:1];
    
    switch (indexPath.section) {
        case 0: {
            cell.textLabel.text = self.conditionsArray[indexPath.row].value;
            cell.detailTextLabel.text = self.conditionsArray[indexPath.row].key;
//            [cell setIndentationLevel:self.conditionsArray[indexPath.row].indentationLevel];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 1: {
            NSInteger idx = indexPath.row / 4;
            switch (indexPath.row % 4) {
                case 0: {
                    cell.textLabel.text = self.rule.actions[idx].type;
                    cell.detailTextLabel.text = @"Type";
                    break;
                }
                case 1: {
                    cell.textLabel.text = self.rule.actions[idx].subject;
                    cell.detailTextLabel.text = @"Subject";
                    break;
                }
                case 2: {
                    cell.textLabel.text = self.rule.actions[idx].message;
                    cell.detailTextLabel.text = @"Message";
                    break;
                }
                case 3: {
                    cell.textLabel.text = [NSString stringWithFormat:@"%lu devices", self.rule.actions[idx].recipients.count];
                    cell.detailTextLabel.text = @"Recipients";
                    break;
                }
            }
            break;
        }
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"9:00 AM, January 1, 2017";
                    cell.detailTextLabel.text = @"Start";
                    break;
                }
                case 1: {
                    cell.textLabel.text = @"-";
                    cell.detailTextLabel.text = @"End";
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 3: {
            cell.textLabel.text = @"9:00 AM, January 1, 2017";
            cell.detailTextLabel.text = @"Trigger";
            break;
        }
        case 4: {
            cell.textLabel.text = self.rule.tags[indexPath.row];
            cell.detailTextLabel.text = @"";
            break;
        }
        default:
            break;
    }
    
    return cell;
}

-(void) makeConditionsObject:(NSArray<SGRuleCondition *> *)ruleConditions andIndendation:(NSInteger )level {
    
    for (SGRuleCondition *ruleCondition in ruleConditions) {
        
        if (ruleCondition.items.count == 0) {
            
            RuleCondition *rC = [[RuleCondition alloc] init];
            rC.key = @"Type";
            rC.value = ruleCondition.type;
            rC.indentationLevel = level;
            [self.conditionsArray addObject:rC];
            
            if ([ruleCondition.type isEqualToString:@"schedule"]) {
                
                RuleCondition *rC1 = [[RuleCondition alloc] init];
                rC1.key = @"Timezone";
                rC1.value = ruleCondition.timezone;
                rC1.indentationLevel = level;
                [self.conditionsArray addObject:rC1];
                
            } else if ([ruleCondition.type isEqualToString:@"landmark"]) {
                
                RuleCondition *rC1 = [[RuleCondition alloc] init];
                rC1.indentationLevel = level;
                rC1.key = @"Landmark Id";
                rC1.value = ruleCondition.ids.firstObject;
                [self.conditionsArray addObject:rC1];
                
                RuleCondition *rC2 = [[RuleCondition alloc] init];
                rC2.key = @"Trigger";
                rC2.value = ruleCondition.trigger;
                rC2.indentationLevel = level;
                [self.conditionsArray addObject:rC2];
                
                RuleCondition *rC3 = [[RuleCondition alloc] init];
                rC3.key = @"Attribute";
                rC3.value = ruleCondition.attribute;
                rC3.indentationLevel = level;
                [self.conditionsArray addObject:rC3];
                
            } else if ([ruleCondition.type isEqualToString:@"attribute"]) {
                
                RuleCondition *rC1 = [[RuleCondition alloc] init];
                rC1.key = @"Attribute";
                rC1.value = ruleCondition.attribute;
                rC1.indentationLevel = level;
                [self.conditionsArray addObject:rC1];
                
                RuleCondition *rC2 = [[RuleCondition alloc] init];
                rC2.key = @"Operator";
                rC2.value = ruleCondition.operator;
                rC2.indentationLevel = level;
                [self.conditionsArray addObject:rC2];
                
                RuleCondition *rC3 = [[RuleCondition alloc] init];
                rC3.key = @"Value";
                rC3.value = [ruleCondition.value stringValue];
                rC3.indentationLevel = level;
                [self.conditionsArray addObject:rC3];
                
            }
        } else {
            RuleCondition *rC = [[RuleCondition alloc] init];
            rC.key = @"Operator";
            rC.value = ruleCondition.type;
            rC.indentationLevel = level;
            [self.conditionsArray addObject:rC];
            [self makeConditionsObject:ruleCondition.items andIndendation:level+1];
            
        }
    }
}

@end
