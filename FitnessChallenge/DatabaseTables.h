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
FOUNDATION_EXPORT NSString *const TABLE_USER_UUID;
FOUNDATION_EXPORT NSString *const TABLE_USER_USERNAME;
FOUNDATION_EXPORT NSString *const TABLE_USER_PASSWORD;
FOUNDATION_EXPORT NSString *const TABLE_USER_NUME;
FOUNDATION_EXPORT NSString *const TABLE_USER_PRENUME;
FOUNDATION_EXPORT NSString *const TABLE_USER_REGISTRATION_DATE;
FOUNDATION_EXPORT NSString *const TABLE_USER_CREATE_STATEMENT;

// Workout Table
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_START_TIME;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_END_TIME;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_ESTE_TEST;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_USER_UUID;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_CREATE_STATEMENT;

// Challenge Table
FOUNDATION_EXPORT NSString *const TABLE_CHALLENGE_CHALLENGER_UUID; // va fi UUID-ul celui ce initiaza challenge-ul
FOUNDATION_EXPORT NSString *const TABLE_CHALLENGE_EXERCISE_NAME;
FOUNDATION_EXPORT NSString *const TABLE_CHALLENGE_USER_UUID;
FOUNDATION_EXPORT NSString *const TABLE_CHALLENGE_CREATE_STATEMENT;

// Badge Table
FOUNDATION_EXPORT NSString *const TABLE_BADGE_NAME;
FOUNDATION_EXPORT NSString *const TABLE_BADGE_DESCRIPTION;
FOUNDATION_EXPORT NSString *const TABLE_BADGE_CREATE_STATEMENT;

// BadgeUser Table
FOUNDATION_EXPORT NSString *const TABLE_BADGE_USER_BADGE_ID;
FOUNDATION_EXPORT NSString *const TABLE_BADGE_USER_USER_UUID;
FOUNDATION_EXPORT NSString *const TABLE_BADGE_USER_CREATE_STATEMENT;

// WorkoutExercise Table
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_EXERCISE_WORKOUT_ID;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_EXERCISE_EXERCISE_NAME;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_EXERCISE_USER_UUID;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_EXERCISE_REPS_NUMBER;
FOUNDATION_EXPORT NSString *const TABLE_WORKOUT_EXERCISE_CREATE_STATEMENT;

@interface DatabaseTables : NSObject

@end

@interface BaseColumns : NSObject

@property NSNumber* _id;

@end

@interface User : BaseColumns

@property NSString* userUUID;
@property NSString* username;
@property NSString* password;
@property NSString* nume;
@property NSString* prenume;
@property NSString* regDate;

@end

@interface Workout : BaseColumns

@property NSString* startTime;
@property NSString* endTime;
@property NSInteger* esteTest;
@property NSString* userUUID;

@end

@interface Challenge : BaseColumns

@property NSString* challengerUUID;
@property NSString* exerciseName;
@property NSString* userUUID;

@end

@interface Badge : BaseColumns

@property NSString* name;
@property NSString* description;

@end

@interface BadgeUser : BaseColumns

@property NSInteger* badgeId;
@property NSString* userUUID;

@end

@interface WorkoutExercise : BaseColumns

@property NSInteger workoutId;
@property NSString* exerciseName;
@property NSString* userUUID;
@property NSInteger numberOfReps;
@end
