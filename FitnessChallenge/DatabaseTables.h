//
//  DatabaseTables.h
//  FitnessChallenge
//
//  Created by Alex on 11/1/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const ID;

// User Table
FOUNDATION_EXPORT NSString *const TABLE_USER_USERNAME;
FOUNDATION_EXPORT NSString *const TABLE_USER_PASSWORD;
FOUNDATION_EXPORT NSString *const TABLE_USER_EMAIL;
FOUNDATION_EXPORT NSString *const TABLE_USER_CREATE_STATEMENT;

// Exercise Table
FOUNDATION_EXPORT NSString *const TABLE_EXERCISE_NAME;
FOUNDATION_EXPORT NSString *const TABLE_EXERCISE_DESCRIPTION;
FOUNDATION_EXPORT NSString *const TABLE_EXERCISE_CREATE_STATEMENT;

// Workout Table
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_NUMBER;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_START_TIME;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_END_TIME;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_USER_ID;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_CREATE_STATEMENT;

// WorkoutExercise Table
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_EXERCISE_WORKOUT_ID;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_EXERCISE_EXERCISE_ID;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_EXERCISE_USER_ID;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_EXERCISE_REPS_NUMBER;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_EXERCISE_CREATE_STATEMENT;


@interface DatabaseTables : NSObject

@end

@interface BaseColumns : NSObject

@property NSInteger* _id;

@end

@interface User : BaseColumns

@property NSString* username;
@property NSString* password;
@property NSString* email;

@end

@interface Exercise : BaseColumns

@property NSString* name;
@property NSString* description;

@end

@interface Workout : BaseColumns

@property NSInteger* workoutNumber;
@property NSDate* startTime;
@property NSDate* endTime;
@property NSInteger* userId;

@end

@interface WorkoutExercise : BaseColumns

@property NSInteger* workoutId;
@property NSInteger* exerciseId;
@property NSInteger* userId;
@property NSInteger* numberOfReps;
@end
