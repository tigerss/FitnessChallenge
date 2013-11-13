//
//  DatabaseHelper.h
//  FitnessChallenge
//
//  Created by Alex on 10/30/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseTables.h"

@interface DatabaseHelper : NSObject

+ (NSArray*) selectUsers;
+ (BOOL) insertUser:(NSString*) username :(NSString*) password :(NSString*) email;
+ (BOOL) updateUser:(User*) user;

+ (BOOL) insertExercise:(NSString*) name :(NSString*) description;
+ (BOOL) insertWorkout:(NSNumber*) workoutNumber :(NSDate*)startTime :(NSDate*)endTime :(NSNumber*) userId;
+ (BOOL) insertWorkoutExercise: (NSNumber*) workoutId :(NSNumber*) exerciseId :(NSNumber*) userId :(NSNumber*) numberOfReps;

+ (BOOL) createDatabase;
+ (BOOL) removeDatabase;
+ (BOOL) openDatabase;
+ (BOOL) closeDatabase;
@end
