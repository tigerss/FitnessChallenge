//
//  NetworkingHelper.h
//  FitnessChallenge
//
//  Created by Alex on 11/27/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "FitnessUser.h"
#import "FitnessWorkout.h"
#import "FitnessExercise.h"
#import "FitnessBadge.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "Utils.h"
#import "PublicChallenge.h"

@interface NetworkingHelper : NSObject

+ (void)synchronizeUserData:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure;

+ (void)insertUserInCloud:(User*) user
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+(void) updateUserInCloud:(FitnessUser*) fitnessUser forceUpdate:(BOOL)force success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

+ (void)fetchChallenges:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
            includeDocs:(BOOL) includeDocs;

+ (void)insertChallenge:(PublicChallenge*) challenge
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)updateChallenge:(PublicChallenge*) challenge
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 Returns the entire leadearboard ordered from the lowest to the highest score
 */
+ (void)fetchLeaderBoard:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 Returns last test score for each user sorted in descending order
 */
+ (void)fetchLastTestScores:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                includeDocs:(BOOL) includeDocs;

/**
 Returns the user from Cloudant or nil if it does not exist
 */
+ (void)fetchUserByUUID:(NSString*)uuid
                success:(void (^)(FitnessUser* fitnessUser))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 Returns the user from Cloudant or nil if it does not exist
 */
+ (void)fetchUserByUserName:(NSString*)userName
          success:(void (^)(FitnessUser* fitnessUser))success
          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (AFHTTPRequestOperation*)prepareJsonNetworkRequest:(NSString*) urlString
                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)postJson:(NSString*) urlString
            data:(NSDictionary*) data
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successCallback
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureCallback;
@end
