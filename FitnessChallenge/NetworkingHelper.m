//
//  NetworkingHelper.m
//  FitnessChallenge
//
//  Created by Alex on 11/27/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "NetworkingHelper.h"
#import "FitnessWorkout.h"
#import "FitnessExercise.h"
#import "Utils.h"

@implementation NetworkingHelper

static NSString* const LEADERBOARD_VIEW = @"https://hendeptycleystordifteric:3WUW8OoJhRVboQjXuBeHmiuK@implementer.cloudant.com/fitnessathome/_design/views/_view/leaderboard?reduce=false&descending=true";

static NSString* const USERS_VIEW = @"https://hendeptycleystordifteric:3WUW8OoJhRVboQjXuBeHmiuK@implementer.cloudant.com/fitnessathome/_design/views/_view/users?reduce=false";

static NSString* const DATABASE_URL = @"https://implementer.cloudant.com/fitnessathome/";

+ (void)synchronizeUserData:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSArray* users = [DatabaseHelper selectUsers];
    if ([users count] <= 0)
    {
        NSLog(@"Nu exista utilizatori, sincronizare terminata");
        return;
    }
    
    @try {
        User* user = [users objectAtIndex:0];
        NSString* userName = [user userUUID];
        [NetworkingHelper fetchUser:userName success:^(FitnessUser* fitnessUser) {
            if (nil == fitnessUser) {
                [NetworkingHelper insertUserInCloud:user];
            } else {
                [NetworkingHelper updateUserInCloud:user :fitnessUser];
            }
        } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        }];
    
        
    } @catch (NSException* ex) {
        NSLog(@"%@", [ex debugDescription]);
    }
}

+(void)insertUserInCloud:(User*) user
{
    // Retrieve workouts
    NSArray* workouts = [DatabaseHelper selectWorkouts];
    
    // Retrieve exercises
    NSArray* exercises = [DatabaseHelper selectWorkoutExercises];
    
    FitnessUser* fitnessUser = [[FitnessUser alloc]init];
    // For each workout get exercises
    for (Workout* workout in workouts) {
        NSNumber* workoutId = [workout _id];
        FitnessWorkout* fitnessWorkout = [NetworkingHelper createFitnessWorkout:[workoutId intValue] from:workout withExercises:exercises];
        [[fitnessUser workouts] addObject:fitnessWorkout];
    }
    // Add name
    [fitnessUser setName:[user userUUID]];
    
    // Build dictionary
    NSDictionary* userDictionary = [fitnessUser toDictionary];
    
    // Insert
    [NetworkingHelper postJson:DATABASE_URL data:userDictionary success:nil failure:nil];
}

+(void) updateUserInCloud:(User*) user :(FitnessUser*) fitnessUser {
    // Retrieve workouts
    NSArray* workouts = [DatabaseHelper selectWorkouts];
    
    // Retrieve exercises
    NSArray* exercises = [DatabaseHelper selectWorkoutExercises];
    
    // Check for missing workouts
    NSMutableDictionary* remoteWorkouts = [[NSMutableDictionary alloc]init];
    for (FitnessWorkout* fitnessWorkout in [fitnessUser workouts]) {
        [remoteWorkouts setObject:fitnessWorkout forKey:[NSNumber numberWithInteger:[fitnessWorkout workoutId]]];
    }
    
    BOOL hasChanges = NO;
    for (Workout* workout in workouts) {
        NSNumber *workoutId = [workout _id];
        id exists = [remoteWorkouts objectForKey:[NSNumber numberWithInt:[workoutId intValue]]];
        if (exists) {
            continue;
        }
        
        hasChanges = YES;
        FitnessWorkout* fitnessWorkout = [NetworkingHelper createFitnessWorkout:[workoutId intValue] from:workout withExercises:exercises];
        [[fitnessUser workouts] addObject:fitnessWorkout];
    }
    
    if (hasChanges) {
        // Build dictionary
        NSDictionary* userDictionary = [fitnessUser toDictionary];
        
        // Update
        [NetworkingHelper updateDocument:DATABASE_URL documentId:[fitnessUser _id] data:userDictionary success:nil failure:nil];
    }
}

+ (FitnessWorkout*) createFitnessWorkout:(int)workoutId from:(Workout*)workout withExercises:(NSArray*)exercises {
    FitnessWorkout* fitnessWorkout = [[FitnessWorkout alloc]init];
    [fitnessWorkout setWorkoutId:workoutId];
    long long startMilliseconds = [Utils convertDateStringToMilliseconds:[workout startTime]];
    [fitnessWorkout setStarTime:startMilliseconds];
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
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager* manager = [NetworkingHelper prepareOperationManager];
    // Now we can just PUT it to our target URL (note the https).
    // This will return immediately, when the transaction has finished,
    // one of either the success or failure blocks will fire
    [manager
     POST: urlString
     parameters: data
     success:^(AFHTTPRequestOperation *operation, id responseObject){
         NSLog(@"Submit response data: %@", responseObject);} // success callback block
     failure:^(AFHTTPRequestOperation *operation, NSError *error){
         NSLog(@"Error: %@", error);} // failure callback block
     ];
}

+ (void)updateDocument:(NSString*) urlString
            documentId:(NSString*) documentId
            data:(NSDictionary*) data
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
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
         NSLog(@"Submit response data: %@", responseObject);} // success callback block
     failure:^(AFHTTPRequestOperation *operation, NSError *error){
         NSLog(@"Error: %@", error);} // failure callback block
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
@end
