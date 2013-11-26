//
//  NetworkingTests.m
//  FitnessChallenge
//
//  Created by Alex on 11/26/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "AFNetworking.h"

@interface NetworkingTests : XCTestCase

@end

@implementation NetworkingTests

static NSString* const CLOUDANT_FITNESS_URL = @"https://hendeptycleystordifteric:3WUW8OoJhRVboQjXuBeHmiuK@implementer.cloudant.com/fitnessathome/_design/views/_view/leaderboard";

- (void) testFetchLeaderBoard {
    __block NSConditionLock *lock = [NSConditionLock new];
    __block id response = nil;
    NSURL *url = [NSURL URLWithString:CLOUDANT_FITNESS_URL];
    NSURLRequest *request = [NSURLRequest  requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        response = responseObject;
        NSLog(@"%@", responseObject);
        [lock unlockWithCondition:1];
    } failure:
     ^(AFHTTPRequestOperation* operation, NSError* error) {
         NSLog(@"%@", [error debugDescription]);
     }];
    [operation start];
//    [lock lockWhenCondition:1];
//    XCTAssertTrue(nil != response);
}
@end
