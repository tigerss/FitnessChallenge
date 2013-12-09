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
NSString *const TABLE_USER_UUID = @"userUUID";
NSString *const TABLE_USER_USERNAME = @"username";
NSString *const TABLE_USER_PASSWORD = @"password";
NSString *const TABLE_USER_NUME = @"nume";
NSString *const TABLE_USER_PRENUME = @"prenume";
NSString *const TABLE_USER_REGISTRATION_DATE = @"regDate";
NSString *const TABLE_USER_CREATE_STATEMENT = @"create table if not exists user (id integer primary key autoincrement, userUUID text, username text, password text, nume text, prenume text, regDate text)";

// Workout Table
NSString *const TABLE_WORKOUT_START_TIME = @"start_time";
NSString *const TABLE_WORKOUT_END_TIME = @"end_time";
NSString *const TABLE_WORKOUT_ESTE_TEST = @"este_test";
NSString *const TABLE_WORKOUT_USER_UUID = @"userUUID";
NSString *const TABLE_WORKOUT_CREATE_STATEMENT = @"create table if not exists workout (id integer primary key autoincrement, start_time text, end_time text, este_test integer, userUUID text)";

// Challenge Table
NSString *const TABLE_CHALLENGE_CHALLENGER_UUID = @"challengerUUID";
NSString *const TABLE_CHALLENGE_EXERCISE_NAME = @"exercise_name";
NSString *const TABLE_CHALLENGE_USER_UUID = @"userUUID";
NSString *const TABLE_CHALLENGE_CREATE_STATEMENT = @"create table if not exists challenge (id integer primary key autoincrement, challengerUUID text, exercise_name text, userUUID text)";

// Badge Table
NSString *const TABLE_BADGE_NAME = @"name";
NSString *const TABLE_BADGE_IMAGE = @"image";
NSString *const TABLE_BADGE_DESCRIPTION = @"description";
NSString *const TABLE_BADGE_CREATE_STATEMENT = @"create table if not exists badge (id integer primary key autoincrement, name text, image text, description text)";

// BadgeUser Table
NSString *const TABLE_BADGE_USER_BADGE_ID = @"badge_id";
NSString *const TABLE_BADGE_USER_USER_UUID = @"userUUID";
NSString *const TABLE_BADGE_USER_CREATE_STATEMENT = @"create table if not exists badge_user (id integer primary key autoincrement, badge_id integer, userUUID text)";

// WorkoutExercise Table
NSString *const TABLE_WORKOUT_EXERCISE_WORKOUT_ID = @"workout_id";
NSString *const TABLE_WORKOUT_EXERCISE_EXERCISE_NAME = @"exercise_name";
NSString *const TABLE_WORKOUT_EXERCISE_USER_UUID = @"userUUID";
NSString *const TABLE_WORKOUT_EXERCISE_REPS_NUMBER = @"reps_number";
NSString *const TABLE_WORKOUT_EXERCISE_CREATE_STATEMENT = @"create table if not exists workout_exercise (id integer primary key autoincrement, workout_id integer, exercise_name text, userUUID text, reps_number integer)";

@implementation DatabaseTables
@end

@implementation BaseColumns
@end

@implementation User
@end

@implementation Workout
@end

@implementation Challenge
@end

@implementation Badge
@end

@implementation BadgeUser
@end

@implementation WorkoutExercise
@end
