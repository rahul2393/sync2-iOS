//
//  SenseAPI.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/17/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SenseAPI.h"
#import "Organization.h"
#import "Project.h"
#import "DataChannel.h"
#import "ProjectLandmark.h"
#import "APIKey.h"
#import "SettingsManager.h"
#import "SDKManager.h"
#import "AppDelegate.h"

@implementation SenseAPI

+ (NSString *) serverAddress{
    
    return [[EnvironmentManager sharedManager] selectedSenseURL];
}

+ (id)sharedManager {
    static SenseAPI *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)setUserToken:(SGToken *)userToken {
    [[SettingsManager sharedManager] setCurrentUserToken:userToken];
}

- (SGToken*)userToken {
    return [[SettingsManager sharedManager] currentUserToken];
}

- (void)setUserOrgToken:(SGToken *)userOrgToken {
    [[SettingsManager sharedManager] setCurrentUserOrgToken:userOrgToken];
}

- (SGToken*)userOrgToken {
   return [[SettingsManager sharedManager] currentUserOrgToken];
}

- (BOOL)checkForUnauthorizedStatus:(NSHTTPURLResponse *) httpResponse {
    if (httpResponse.statusCode == 401) {
        dispatch_async(dispatch_get_main_queue(), ^{
            AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDel showLoginScreen];
        });
        NSLog(@"Error %ld, take user to the login screen", (long)httpResponse.statusCode);
        return true;
    }
    
    return false;
}

#pragma mark - Authentication

-(void) LoginWithEmail:(NSString *_Nonnull)email andPassword:(NSString *_Nonnull)password
        withCompletion:(void ( ^ _Nullable )(NSError * _Nullable error))completed{
    
    self.userToken = nil;
    self.userOrgToken = nil;
    
    NSDictionary *headers = @{ @"Content-type": @"application/json" };
    NSDictionary *parameters = @{ @"email": email,
                                  @"password": password };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self urlForEndPoint:@"/v2/login"]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                        completed(error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        if (httpResponse.statusCode == 401) {
                                                            NSError *err = [NSError errorWithDomain:@"iOS app generated" code:httpResponse.statusCode userInfo:@{ NSLocalizedDescriptionKey:@"Invalid username password" }];
                                                            completed(err);
                                                        }
                                                        
                                                        SGToken *token = [[SGToken alloc]initWithData:data];
                                                        NSLog(@"Received user token %@", token.token);
                                                        if ([token.token isEqualToString:@""]) {
                                                            completed(nil);
                                                            return;
                                                        }
                                                        self.userToken = token;
                                                        [[SettingsManager sharedManager] setCurrentAccountEmail:email];
                                                        [self GetOrganizationsIds:^(NSArray *orgIds, NSError * _Nullable error) {
                                                            [self SetOrgId:orgIds[0] withCompletion:^(NSError * _Nullable error) {
                                                                completed(nil);
                                                            }];
                                                        }];
                                                    }
                                                }];
    [dataTask resume];
}

# pragma mark - Get Organizations

// This is janky as hell.

-(void) GetOrganizationsIds:(void ( ^ _Nullable )(NSArray *orgIds, NSError * _Nullable error))completed{
    NSDictionary *headers = @{ @"Authorization": [self bearerToken],
                               @"Accept": @"application/json",
                               @"Connection": @"keep-alive" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self urlForEndPoint:@"/v2/organizations"]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        if ([self checkForUnauthorizedStatus:httpResponse]) {
                                                            return;
                                                        }
                                                        
                                                        NSArray *orgIds = [self organizationIdsFromData:data];
                                                        completed(orgIds, nil);
                                                    }
                                                }];
    [dataTask resume];
}

-(void) SetOrgId:(NSString *_Nonnull)orgId withCompletion:(void ( ^ _Nullable )(NSError * _Nullable error))completed{
    
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Authorization": [self bearerToken] };
    NSDictionary *parameters = @{ @"organizationId": orgId };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self urlForEndPoint:@"/v2/set-organization"]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                        completed(error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        if ([self checkForUnauthorizedStatus:httpResponse]) {
                                                            return;
                                                        }
                                                        
                                                        self.userOrgToken = [[SGToken alloc]initWithData:data];
                                                        completed(nil);
                                                    }
                                                }];
    [dataTask resume];
}

# pragma mark - Get Organizations

- (void)GetOrganizationsWithCompletion:(void (^)(NSArray *, NSError * _Nullable))completed{
    
    NSDictionary *headers = @{ @"Authorization": [self bearerToken],
                               @"Accept": @"application/json",
                               @"Connection": @"keep-alive" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self urlForEndPoint:@"/v2/organizations"]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        if ([self checkForUnauthorizedStatus:httpResponse]) {
                                                            return;
                                                        }
                                                        
                                                        NSArray *orgs = [self organizationIdsFromData:data];
                                                        completed(orgs, nil);
                                                    }
                                                }];
    [dataTask resume];
}

# pragma mark - Get Projects

-(void) GetProjectsWithCompletion:(void ( ^ _Nullable )(NSArray * projects, NSError * _Nullable error))completed{
    
    NSDictionary *headers = @{ @"Authorization": [self bearerOrgToken],
                               @"Accept": @"application/json",
                               @"Connection": @"keep-alive" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self urlForEndPoint:@"/v2/projects"]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        if ([self checkForUnauthorizedStatus:httpResponse]) {
                                                            return;
                                                        }
                                                        
                                                        NSArray *projects = [self projectsFromData:data];
                                                        completed(projects, nil);
                                                    }
                                                }];
    [dataTask resume];
}

-(void) GetAPIKeys:(void ( ^ _Nullable )(NSArray * apiKeys, NSError * _Nullable error))completed{
    
    NSDictionary *headers = @{ @"Authorization": [self bearerOrgToken],
                               @"Accept": @"application/json",
                               @"Connection": @"keep-alive" };
    
    NSString *channelId = [[[SettingsManager sharedManager] selectedDataChannel] objectId];
    NSString *fmt = [NSString stringWithFormat:@"/v2/channels/%@/api-keys", channelId];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self urlForEndPoint:fmt]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    [self formatURLRequest:request];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        if ([self checkForUnauthorizedStatus:httpResponse]) {
                                                            return;
                                                        }
                                                        
                                                        NSArray *apiKeys = [self apiKeysFomData:data];
                                                        APIKey *k = [apiKeys firstObject];
                                                        [[SDKManager sharedManager] setCurrentAPIKey:k.apiKey];
                                                        [[SDKManager sharedManager] stopSDK];
                                                        
                                                        [[SDKManager sharedManager] startSDKWithAPIKey:k.apiKey andSuccessHandler:^{
                                                            completed(nil, nil);
                                                        } andFailureHandler:^(NSString *failureMessage) {
                                                            NSError *err = [NSError errorWithDomain:@"iOS app generated" code:httpResponse.statusCode userInfo:@{NSLocalizedDescriptionKey:failureMessage}];
                                                            completed(nil, err);
                                                        }];
                                                    }
                                                }];
    [dataTask resume];
}

# pragma mark - Get Data Channels

-(void) GetDataChannelsWithCompletion:(void ( ^ _Nullable )(NSArray *dataChannels, NSError * _Nullable error))completed{
    
    NSDictionary *headers = @{ @"Authorization": [self bearerOrgToken],
                               @"Accept": @"application/json",
                               @"Connection": @"keep-alive" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self urlForEndPoint:@"/v2/channels"]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    [self formatURLRequest:request];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        if ([self checkForUnauthorizedStatus:httpResponse]) {
                                                            return;
                                                        }
                                                        
                                                        NSArray *channels = [self channelsFromData:data];
                                                        completed(channels, nil);
                                                    }
                                                }];
    [dataTask resume];
    
}


# pragma mark - Get Landmarks

-(void) GetLandmarksForProject:(NSString *_Nonnull)projectId WithCompletion:(void ( ^ _Nullable )(NSArray *landmarks, NSError * _Nullable error))completed{
    
    NSDictionary *headers = @{ @"Authorization": [self bearerOrgToken],
                               @"Content-Type": @"application/json" };
    
    NSDictionary *parameters = @{ @"projectId": projectId,
                                  @"limit": @20,
                                  @"offset": @0};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self urlForEndPoint:@"/v2/landmarks/search"]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        if ([self checkForUnauthorizedStatus:httpResponse]) {
                                                            return;
                                                        }
                                                        
                                                        NSArray *landmarks = [self landmarksFromData:data];
                                                        completed(landmarks, nil);
                                                    }
                                                }];
    [dataTask resume];
}

# pragma mark -

- (void)formatURLRequest:(NSURLRequest *)request{
    NSMutableString *message = [NSMutableString stringWithString:@"---REQUEST------------------\n"];
    [message appendFormat:@"URL: %@\n",[request.URL description] ];
    [message appendFormat:@"METHOD: %@\n",[request HTTPMethod]];
    for (NSString *header in [request allHTTPHeaderFields])
    {
        [message appendFormat:@"%@: %@\n",header,[request valueForHTTPHeaderField:header]];
    }
    [message appendFormat:@"BODY: %@\n",[[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]];
    [message appendString:@"----------------------------\n"];
    printf("%s", [message UTF8String]);
}

-(NSArray *) organizationIdsFromData:(NSData *)data{
    NSMutableArray *toReturn = [NSMutableArray array];
    
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:data
                 options:0
                 error:&error];
    
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDict = (NSDictionary *)object;
        if(responseDict[@"data"]){
            NSArray *orgs = (NSArray *)responseDict[@"data"];
            for (NSDictionary *org in orgs) {
                NSString *orgID = org[@"id"];
                NSString *orgName = org[@"name"];
                [toReturn addObject:orgID];
            }
        }
    }
    
    return toReturn;
}

-(NSArray *) landmarksFromData:(NSData *) data{
    NSMutableArray *toReturn = [NSMutableArray array];
    
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:data
                 options:0
                 error:&error];
    
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDict = (NSDictionary *)object;
        if(responseDict[@"data"]){
            NSArray *landmarkObjects = (NSArray *)responseDict[@"data"];
            for (NSDictionary *lmo in landmarkObjects) {
                ProjectLandmark *p = [[ProjectLandmark alloc] initWithData:lmo];
                [toReturn addObject:p];
            }
        }
    }
    
    
    return toReturn;
}

-(NSArray *) apiKeysFomData:(NSData *) data{
    NSMutableArray *toReturn = [NSMutableArray array];
    
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:data
                 options:0
                 error:&error];
    
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDict = (NSDictionary *)object;
        if(responseDict[@"data"]){
            NSArray *apis = (NSArray *)responseDict[@"data"];
            for (NSDictionary *apiObject in apis) {
                APIKey *a = [[APIKey alloc] initWithData:apiObject];
                [toReturn addObject:a];
            }
        }
    }
    
    
    return toReturn;
}


-(NSArray *) channelsFromData:(NSData *) data{
    NSMutableArray *toReturn = [NSMutableArray array];
    
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:data
                 options:0
                 error:&error];
    
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDict = (NSDictionary *)object;
        if(responseDict[@"data"]){
            NSArray *projectObjects = (NSArray *)responseDict[@"data"];
            for (NSDictionary *projectObject in projectObjects) {
                DataChannel *p = [[DataChannel alloc] initWithData:projectObject];
                [toReturn addObject:p];
            }
        }
    }
    
    
    return toReturn;
}

-(NSArray *) projectsFromData:(NSData *) data{
    NSMutableArray *toReturn = [NSMutableArray array];
    
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:data
                 options:0
                 error:&error];
    
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDict = (NSDictionary *)object;
        if(responseDict[@"data"]){
            NSArray *projectObjects = (NSArray *)responseDict[@"data"];
            for (NSDictionary *projectObject in projectObjects) {
                Project *p = [[Project alloc] initWithData:projectObject];
                [toReturn addObject:p];
            }
        }
    }
    
    
    return toReturn;
}

-(NSString *) bearerToken{
    if (self.userToken) {
        return [NSString stringWithFormat:@"Bearer %@",self.userToken.token];
    }
    
    return @"";
}

-(NSString *) bearerOrgToken{
    if (self.userOrgToken) {
        return [NSString stringWithFormat:@"Bearer %@",self.userOrgToken.token];
    }
    
    return @"";
}


-(NSString *) urlForEndPoint:(NSString *)endpoint{
    return [NSString stringWithFormat:@"%@%@", [SenseAPI serverAddress], endpoint];
}


@end
