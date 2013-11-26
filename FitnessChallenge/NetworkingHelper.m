//
//  NetworkingHelper.m
//  FitnessChallenge
//
//  Created by Alex on 11/27/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "NetworkingHelper.h"

@implementation NetworkingHelper

static NSString* const LEADERBOARD_VIEW = @"https://hendeptycleystordifteric:3WUW8OoJhRVboQjXuBeHmiuK@implementer.cloudant.com/fitnessathome/_design/views/_view/leaderboard?reduce=false";

+ (void)fetchLeaderBoard:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:LEADERBOARD_VIEW];
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
    [operation start];

}
@end
