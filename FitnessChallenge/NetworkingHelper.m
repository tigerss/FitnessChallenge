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

static NSString* const VIEW_UUID = @"https://hendeptycleystordifteric:3WUW8OoJhRVboQjXuBeHmiuK@implementer.cloudant.com/fitnessathome/_design/views/_view/uuid?reduce=false";

static NSString* const DATABASE_URL = @"https://implementer.cloudant.com/fitnessathome/";

static NSString* const VIEW_LAST_TESTS_SCORE = @"https://hendeptycleystordifteric:3WUW8OoJhRVboQjXuBeHmiuK@implementer.cloudant.com/fitnessathome/_design/views/_view/last_test_scores?reduce=false&descending=true";

static NSString* const VIEW_CHALLENGES = @"https://hendeptycleystordifteric:3WUW8OoJhRVboQjXuBeHmiuK@implementer.cloudant.com/fitnessathome/_design/views/_view/challenges?reduce=false";

+ (void)synchronizeUserData:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSArray* users = [DatabaseHelper selectUsers];
    if ([users count] <= 0)
    {
        NSLog(@"Nu exista utilizatori, sincronizare terminata");
        return;
    }
    
    @try {
        User* user = [users objectAtIndex:0];
        NSString* uuid = [user userUUID];
        [NetworkingHelper fetchUserByUUID:uuid success:^(FitnessUser* fitnessUser) {
            if (nil == fitnessUser) {
                [NetworkingHelper insertUserInCloud:user success:nil failure:nil];
            } else {
                [NetworkingHelper updateUserInCloud:fitnessUser forceUpdate:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   // do nothing
                } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
                    // do nothing
                }];
            }
        } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        }];
    
        
    } @catch (NSException* ex) {
        NSLog(@"%@", [ex debugDescription]);
    }
}

+(void)insertUserInCloud:(User*) user success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    // Retrieve workouts
    NSArray* workouts = [DatabaseHelper selectWorkouts];
    
    // Retrieve exercises
    NSArray* exercises = [DatabaseHelper selectWorkoutExercises];
    
    //Retrieve badges
    NSArray* badges = [DatabaseHelper selectUserBadges:[user userUUID]];
    
    FitnessUser* fitnessUser = [[FitnessUser alloc]init];
    // For each workout get exercises
    for (Workout* workout in workouts) {
        NSNumber* workoutId = [workout _id];
        FitnessWorkout* fitnessWorkout = [NetworkingHelper createFitnessWorkout:[workoutId intValue] from:workout withExercises:exercises];
        [[fitnessUser workouts] addObject:fitnessWorkout];
    }
    // Add badges
    for (Badge* badge in badges) {
        FitnessBadge* fitnessBadge = [FitnessBadge fromBadge: badge];
        [[fitnessUser badges] addObject:fitnessBadge];
    }
    // Add name
    [fitnessUser setName:[user username]];
    [fitnessUser setPassword:[user password]];
    [fitnessUser setUuid:[user userUUID]];
    [fitnessUser setNume:[user nume]];
    [fitnessUser setPrenume:[user prenume]];
    
    // Build dictionary
    NSDictionary* userDictionary = [fitnessUser toDictionary];
    
    // Insert
    [NetworkingHelper postJson:DATABASE_URL data:userDictionary success:success failure:failure];
}

+(void) updateUserInCloud:(FitnessUser*) fitnessUser
              forceUpdate:(BOOL)force
                  success:(void (^)(AFHTTPRequestOperation *, id))success
                  failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    // Retrieve workouts
    NSArray* workouts = [DatabaseHelper selectWorkouts];
    
    // Retrieve exercises
    NSArray* exercises = [DatabaseHelper selectWorkoutExercises];
    
    // Retrieve badges
    NSArray* badges = [DatabaseHelper selectUserBadges:[fitnessUser uuid]];
    
    // Check for missing workouts
    NSMutableDictionary* remoteWorkouts = [[NSMutableDictionary alloc]init];
    for (FitnessWorkout* fitnessWorkout in [fitnessUser workouts]) {
        [remoteWorkouts setObject:fitnessWorkout forKey:[NSNumber numberWithLongLong:[fitnessWorkout startTime]]];
    }
    NSMutableDictionary* localWorkouts = [[NSMutableDictionary alloc]init];
    for (Workout* workout in workouts) {
        [localWorkouts setObject:workout forKey:[workout startTimeInMilliseconds]];
    }
    NSMutableDictionary* remoteBadges = [[NSMutableDictionary alloc]init];
    for (FitnessBadge* fitnessBadge in [fitnessUser badges]) {
        [remoteBadges setObject:fitnessBadge forKey:[fitnessBadge name]];
    }
    NSMutableDictionary* localBadges = [[NSMutableDictionary alloc]init];
    for (Badge* badge in badges) {
        [localBadges setObject:badge forKey:[badge name]];
    }
    
    for (FitnessWorkout* fitnessWorkout in [fitnessUser workouts]) {
        id exists = [localWorkouts objectForKey:[NSNumber numberWithLongLong:[fitnessWorkout startTime]]];
        if (exists) {
            continue;
        }
        
        Workout* workout = [Workout createFrom: fitnessWorkout withUUID: [fitnessUser uuid]];
        [DatabaseHelper insertWorkout:[workout startTime] :[workout endTime] :[NSNumber numberWithInt:[workout esteTest]] :[workout userUUID]];
        int lastInsertedRowId = [DatabaseHelper getLastInsertRowId];
        for (FitnessExercise* fitnessExercise in [fitnessWorkout exercises]) {
            [DatabaseHelper insertWorkoutExercise:[NSNumber numberWithInt:lastInsertedRowId] :[fitnessExercise name] :[fitnessUser uuid] :[NSNumber numberWithInt:[fitnessExercise reps]]];
        }
    }
    
    BOOL hasChanges = NO || force;
    for (Workout* workout in workouts) {
        NSNumber* workoutId = [workout _id];
        id exists = [remoteWorkouts objectForKey:[workout startTimeInMilliseconds]];
        if (exists) {
            continue;
        }
        
        hasChanges = YES;
        FitnessWorkout* fitnessWorkout = [NetworkingHelper createFitnessWorkout:[workoutId intValue] from:workout withExercises:exercises];
        [[fitnessUser workouts] addObject:fitnessWorkout];
    }
    
    for (FitnessBadge* fitnessBadge in [fitnessUser badges]) {
        id exists = [localBadges objectForKey:[fitnessBadge name]];
        if (exists) {
            continue;
        }
        
        Badge* missingBadge = [DatabaseHelper selectBadgeByName:[fitnessBadge name]];
        [DatabaseHelper insertBadgeUser:[missingBadge _id] :[fitnessUser uuid]];
    }
    for (Badge* badge in badges) {
        id exists = [remoteBadges objectForKey:[badge name]];
        if (exists) {
            continue;
        }
        
        hasChanges = YES;
        FitnessBadge* fitnessBadge = [FitnessBadge fromBadge:badge];
        [[fitnessUser badges] addObject:fitnessBadge];
    }
    
    if (hasChanges) {
        // Build dictionary
        NSDictionary* userDictionary = [fitnessUser toDictionary];
        
        // Update
        [NetworkingHelper updateDocument:DATABASE_URL documentId:[fitnessUser _id] data:userDictionary success:success failure:failure];
    }
}

+ (FitnessWorkout*) createFitnessWorkout:(int)workoutId from:(Workout*)workout withExercises:(NSArray*)exercises {
    FitnessWorkout* fitnessWorkout = [[FitnessWorkout alloc]init];
    [fitnessWorkout setWorkoutId:workoutId];
    long long startMilliseconds = [Utils convertDateStringToMilliseconds:[workout startTime]];
    [fitnessWorkout setStartTime:startMilliseconds];
    long long endMillisenconds = [Utils convertDateStringToMilliseconds:[workout endTime]];
    [fitnessWorkout setEndTime:endMillisenconds];
    
    for (WorkoutExercise* exercise in exercises) {
        int exerciseWorkoutId = [exercise workoutId];
        
        if (exerciseWorkoutId == workoutId) {
            FitnessExercise* fitnessExercise = [[FitnessExercise alloc] init];
            [fitnessExercise setName:[exercise exerciseName]];
            [fitnessExercise setReps:[exercise numberOfReps]];
            [[fitnessWorkout exercises] addObject:fitnessExercise];
        }
    }
    
    return fitnessWorkout;
}

+ (void)fetchChallenges:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
            includeDocs:(BOOL) includeDocs
{
    NSString* url = VIEW_CHALLENGES;
    if (includeDocs) {
        url = [url stringByAppendingString:@"&include_docs=true"];
    }
    
    AFHTTPRequestOperation *operation = [NetworkingHelper prepareJsonNetworkRequest:url success:success failure:failure];
    [operation start];
}

+ (void)insertChallenge:(PublicChallenge*) challenge
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSDictionary* challengeDictionary = [challenge toDictionary];
    [NetworkingHelper postJson:DATABASE_URL data:challengeDictionary success:success failure:failure];
}

+ (void)updateChallenge:(PublicChallenge*) challenge
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    // Build dictionary
    NSDictionary* challengeDictionary = [challenge toDictionary];
    
    // Update
    [NetworkingHelper updateDocument:DATABASE_URL documentId:[challenge _id] data:challengeDictionary success:success failure:failure];
}

/**
 Returns the entire leadearboard orderd from the lowest to the highest score
 */
+ (void)fetchLeaderBoard:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation = [NetworkingHelper prepareJsonNetworkRequest:LEADERBOARD_VIEW success:success failure:failure];
    [operation start];
}

+ (void)fetchLastTestScores:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                includeDocs:(BOOL) includeDocs
{
    NSString* url = VIEW_LAST_TESTS_SCORE;
    if (includeDocs) {
        url = [url stringByAppendingString:@"&include_docs=true"];
    }
    AFHTTPRequestOperation *operation = [NetworkingHelper prepareJsonNetworkRequest:url success:success failure:failure];
    [operation start];
}

/**
 Returns the user from Cloudant or nil if it does not exist
 */
+ (void)fetchUserByUserName:(NSString*)userName
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
            NSDictionary* doc = [userDictionary objectForKey:@"doc"];
            fitnessUser = [FitnessUser fromDictionary:doc];
        } else {
            fitnessUser = nil;
        }
        
        success(fitnessUser);
    };
    
    NSString* key = [@"&key=" stringByAppendingFormat:@"%%22%@%%22", userName];
    NSString* includeDocs = [@"&include_docs=true" stringByAppendingString:key];
    NSString* urlPath = [USERS_VIEW stringByAppendingString:includeDocs];
    AFHTTPRequestOperation* operation = [NetworkingHelper prepareJsonNetworkRequest:urlPath success:parseUser failure:failure];
    [operation start];
}

/**
 Returns the user from Cloudant or nil if it does not exist
 */
+ (void)fetchUserByUUID:(NSString*)uuid
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
            NSDictionary* doc = [userDictionary objectForKey:@"doc"];
            fitnessUser = [FitnessUser fromDictionary:doc];
        } else {
            fitnessUser = nil;
        }
        
        success(fitnessUser);
    };
    
    NSString* key = [@"&key=" stringByAppendingFormat:@"%%22%@%%22", uuid];
    NSString* includeDocs = [@"&include_docs=true" stringByAppendingString:key];
    NSString* urlPath = [VIEW_UUID stringByAppendingString:includeDocs];
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

+ (void)postJson:(NSString*) urlString
            data:(NSDictionary*) data
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successCallback
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureCallback
{
    if (nil == successCallback) {
        successCallback = emptyBlock;
    }
    if (nil == failureCallback) {
        failureCallback = emptyFailureBlock;
    }
    AFHTTPRequestOperationManager* manager = [NetworkingHelper prepareOperationManager];
    // Now we can just PUT it to our target URL (note the https).
    // This will return immediately, when the transaction has finished,
    // one of either the success or failure blocks will fire
    [manager
     POST: urlString
     parameters: data
     success:^(AFHTTPRequestOperation *operation, id responseObject){
         NSLog(@"Submit response data: %@", responseObject);
         successCallback(operation, responseObject);
     } // success callback block
     failure:^(AFHTTPRequestOperation *operation, NSError *error){
         NSLog(@"Error: %@", error);
         failureCallback(operation, error);
     } // failure callback block
     ];
}

+ (void)updateDocument:(NSString*) urlString
            documentId:(NSString*) documentId
            data:(NSDictionary*) data
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successCallback
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureCallback
{
    AFHTTPRequestOperationManager* manager = [NetworkingHelper prepareOperationManager];
    // Now we can just PUT it to our target URL (note the https).
    // This will return immediately, when the transaction has finished,
    // one of either the success or failure blocks will fire
    NSString* finalUrl = [urlString stringByAppendingFormat:@"%@", documentId];
    [manager
     PUT: finalUrl
     parameters: data
     success:^(AFHTTPRequestOperation *operation, id responseObject){
         NSLog(@"Submit response data: %@", responseObject);
         successCallback(operation, responseObject);
     } // success callback block
     failure:^(AFHTTPRequestOperation *operation, NSError *error){
         NSLog(@"Error: %@", error);
         failureCallback(operation, error);
     } // failure callback block
     ];
}

+ (AFHTTPRequestOperationManager*) prepareOperationManager {
    // it all starts with a manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // in my case, I'm in prototype mode, I own the network being used currently,
    // so I can use a self generated cert key, and the following line allows me to use that
    manager.securityPolicy.allowInvalidCertificates = YES;
    // Make sure we a JSON serialization policy, not sure what the default is
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // No matter the serializer, they all inherit a battery of header setting APIs
    // Here we do Basic Auth, never do this outside of HTTPS
    [manager.requestSerializer
     setAuthorizationHeaderFieldWithUsername:@"hendeptycleystordifteric"
     password:@"3WUW8OoJhRVboQjXuBeHmiuK"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    return manager;
}

void (^emptyBlock)(AFHTTPRequestOperation*, id) = ^void (AFHTTPRequestOperation *operation, id responseObject)
{
    // useful empty block :)
};

void (^emptyFailureBlock)(AFHTTPRequestOperation*, NSError*) = ^void (AFHTTPRequestOperation* operation, NSError* error)
{
    // useful empty block :)
};
@end
