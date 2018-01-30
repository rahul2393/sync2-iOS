//
//  SenseAPI.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/17/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SenseNetworkManager.h"
#import "SGToken.h"
@interface SenseAPI : NSObject<SenseNetworkManagerInterface>

@property (nonatomic, strong) SGToken *jwToken;


@end
