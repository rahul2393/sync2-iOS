//
//  WelcomeNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "WelcomeNotificationTableViewCell.h"
#import "UITapGestureRecognizerExtension.h"
#import "TFHpple.h"

@interface WelcomeNotificationTableViewCell ()
@property (nonatomic, strong) NSString *pTagContent;
@property (nonatomic, strong) NSString *aTagContent;
@property (nonatomic, strong) NSString *aTagURL;
@end

@implementation WelcomeNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)];
    [self.detailLabel addGestureRecognizer:tapGestureRecognizer];
    self.detailLabel.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(Notification *)notification {
    self.titleLabel.text = notification.title;
    
    [self parseHTMLTags:notification.body];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.pTagContent attributes:nil];
    NSDictionary *linkAttributes = @{ NSForegroundColorAttributeName : [UIColor colorWithRed:0.05 green:0.4 blue:0.65 alpha:1.0],
                                      NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle) };
    
    NSRange linkRange = [self.pTagContent rangeOfString:self.aTagContent];
    [attributedString setAttributes:linkAttributes range:linkRange];
    self.detailLabel.attributedText = attributedString;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(notification.timestamp / 1000.0)]]];
}

- (void)labelTapped:(UITapGestureRecognizer *)recognizer {
    
    NSString *text = self.detailLabel.text;
    NSRange linkRange = [text rangeOfString:self.aTagContent];
    
    if ([recognizer didTapAttributedTextInLabel:self.detailLabel inRange:linkRange]) {
        NSURL *url = [[NSURL alloc] initWithString:self.aTagURL];
        [[UIApplication sharedApplication] openURL:url];
    }
}

-(void)parseHTMLTags:(NSString *)htmlString {
    NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:htmlData];
    
    // set pTagData
    
    NSString *pTagXpathQueryString = @"/html/body/p";
    NSArray *pTagArray = [tutorialsParser searchWithXPathQuery:pTagXpathQueryString];
    TFHppleElement *pTagElement = pTagArray[0];
    self.pTagContent = pTagElement.content;
    
    // set aTagContent and aTagURL
    
    TFHppleElement *aTagContentElement = pTagElement.children[1];
    self.aTagContent = aTagContentElement.content;
    self.aTagURL = aTagContentElement.attributes[@"href"];
}

@end
