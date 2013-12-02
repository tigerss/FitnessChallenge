//
//  NetworkingHelper.m
//  FitnessChallenge
//
//  Created by Alex on 11/27/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "NetworkingHelper.h"

@implementation NetworkingHelper

static NSString* const LEADERBOARD_VIEW = @"https://hendeptycleystordifteric:3WUW8OoJhRVboQjXuBeHmiuK@implementer.cloudant.com/fitnessathome/_design/views/_view/leaderboard?reduce=false&descending=true";

static NSString* const USERS_VIEW = @"https://hendeptycleystordifteric:3WUW8OoJhRVboQjXuBeHmiuK@implementer.cloudant.com/fitnessathome/_design/views/_view/users?reduce=false";

/**
 Returns the entire leadearboard orderd from the lowest to the highest score
 */
+ (void)fetchLeaderBoard:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation = [NetworkingHelper prepareJsonNetworkRequest:LEADERBOARD_VIEW success:success failure:failure];
    [operation start];
}

/**
 Returns the user from Cloudant or nil if it does not exist
 */
+ (void)fetchUser:(NSString*)userName
          success:(void (^)(FitnessUser* fitnessUser))success
          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    void (^parseUser)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        FitnessUser* fitnessUser = [[FitnessUser alloc] init];
        NSDictionary* response = (NSDictionary*) responseObject;
        NSMutableArray* rows = [response objectForKey:@"rows"];
        NSUInteger size = [rows count];
        if (size > 0) {
            NSDictionary* userDictionary = [rows objectAtIndex:0];
            [fitnessUser setName:[userDictionary objectForKey:@"key"]];
        } else {
            fitnessUser = nil;
        }
        
        success(fitnessUser);
    };
    
    NSString* key = [@"&key=" stringByAppendingFormat:@"%%22%@%%22", userName];
    NSString* urlPath = [USERS_VIEW stringByAppendingString:key];
    AFHTTPRequestOperation* operation = [NetworkingHelper prepareJsonNetworkRequest:urlPath success:parseUser failure:failure];
    [operation start];
}

/**
 Builder for AFHTTPRequestOperation. Don't forget to call [operation start];
 */
+ (AFHTTPRequestOperation*)prepareJsonNetworkRequest:(NSString*) urlString
                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest  requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        success(operation, responseObject);
    } failure:
     ^(AFHTTPRequestOperation* operation, NSError* error) {
         NSLog(@"%@", [error debugDescription]);
         failure(operation,error);
     }];
    
    return operation;
}
@end
