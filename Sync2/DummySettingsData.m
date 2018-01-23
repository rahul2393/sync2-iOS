//
//  DummySettingsData.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/23/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "DummySettingsData.h"

@implementation DummySettingsData

+(Project *) project{
    Project *p = [[Project alloc] init];
    p.name = @"City";
    return p;
}

+(DataChannel *) dataChannel{
    DataChannel *dc = [[DataChannel alloc]init];
    dc.name = @"City Planning";
    return dc;
}

+(Account *) account{
    Account *a = [[Account alloc] init];
    a.accountEmail = @"rkirkendall@sixgill.com";
    return a;
}

+(NSString *) apiURL{
    return @"sense-api.sixgill.io";
}

@end
