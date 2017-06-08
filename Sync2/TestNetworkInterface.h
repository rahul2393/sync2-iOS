//
//  TestNetworkInterface.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"
@interface TestNetworkInterface : NSObject<NetworkManagerInterface>

-(void) AccountForQRCodeId:(NSString *_Nonnull)qrCode withCompletion:(void ( ^ _Nullable )(NSDictionary * _Nullable accountData, NSError * _Nullable error))completed;

@end
