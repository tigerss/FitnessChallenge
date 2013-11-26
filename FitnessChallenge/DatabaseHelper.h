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
+ (BOOL) selectUsersForAuth:(NSString*) username :(NSString*) password;
+ (BOOL) selectUsersWithName:(NSString*) lname :(NSString*) fname;
+ (BOOL) selectUsersNr;
+ (BOOL) insertUser:(NSString*) username :(NSString*) password :(NSString*) nume :(NSString*) prenume :(NSString*) regDate;
+ (BOOL) updateUser:(NSString*) username :(NSString*) password :(NSString*) nume :(NSString*) prenume :(NSString*) regDate :(NSString*) usr;

+ (BOOL) insertWorkout:(NSString*)startTime :(NSString*)endTime :(NSNumber*) esteTest :(NSNumber*) userId;
+ (BOOL) insertWorkoutExercise: (NSNumber*) workoutId :(NSNumber*) exerciseId :(NSNumber*) userId :(NSNumber*) numberOfReps;

+ (BOOL) createDatabase;
+ (BOOL) removeDatabase;
+ (BOOL) openDatabase;
+ (BOOL) closeDatabase;
@end
