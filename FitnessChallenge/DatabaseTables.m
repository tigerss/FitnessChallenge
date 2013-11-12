//
//  DatabaseTables.m
//  FitnessChallenge
//
//  Created by Alex on 11/1/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "DatabaseTables.h"

NSString *const ID = @"id";

// User Table
NSString *const TABLE_USER_USERNAME = @"username";
NSString *const TABLE_USER_PASSWORD = @"password";
NSString *const TABLE_USER_EMAIL = @"email";
NSString *const TABLE_USER_CREATE_STATEMENT = @"create table if not exists user (id integer primary key autoincrement, username text, password text, email text)";

// Exercise Table
NSString *const TABLE_EXERCISE_NAME = @"name";
NSString *const TABLE_EXERCISE_DESCRIPTION = @"description";
NSString *const TABLE_EXERCISE_CREATE_STATEMENT = @"create table if not exists exercise (id integer primary key autoincrement, name text, description text)";

// Workout Table
NSString *const TABLE_WORKOUT_NUMBER = @"workout_number";
NSString *const TABLE_WORKOUT_START_TIME = @"start_time";
NSString *const TABLE_WORKOUT_END_TIME = @"end_time";
NSString *const TABLE_WORKOUT_USER_ID = @"user_id";
NSString *const TABLE_WORKOUT_CREATE_STATEMENT = @"create table if not exists workout (id integer primary key autoincrement, workout_number integer, start_time integer, end_time integer, user_id integer)";

// WorkoutExercise Table
NSString *const TABLE_WORKOUT_EXERCISE_WORKOUT_ID = @"workout_id";
NSString *const TABLE_WORKOUT_EXERCISE_EXERCISE_ID = @"exercise_id";
NSString *const TABLE_WORKOUT_EXERCISE_USER_ID = @"user_id";
NSString *const TABLE_WORKOUT_EXERCISE_REPS_NUMBER = @"reps_number";
NSString *const TABLE_WORKOUT_EXERCISE_CREATE_STATEMENT = @"create table if not exists workout_exercise (id integer primary key autoincrement, workout_id integer, exercise_id integer, user_id integer, reps_number integer)";

@implementation DatabaseTables
@end

@implementation BaseColumns
@end

@implementation User
@end

@implementation Exercise
@end

@implementation Workout
@end

@implementation WorkoutExercise
@end
