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
+ (NSArray*) selectWorkout;
+ (BOOL) selectUsersForAuth:(NSString*) username :(NSString*) password;

+ (BOOL) selectUsersWithName:(NSString*) lname :(NSString*) fname;

+ (BOOL) selectUsersNr;

+ (BOOL) insertUser:(NSString*) usrUUID :(NSString*) username :(NSString*) password :(NSString*) nume :(NSString*) prenume :(NSString*) regDate;

+ (BOOL) updateUser:(NSString*) username :(NSString*) password :(NSString*) nume :(NSString*) prenume :(NSString*) regDate :(NSString*) usr;

+ (BOOL) insertWorkout:(NSString*)startTime :(NSString*)endTime :(NSNumber*)esteTest :(NSString*)usrUUID;

+ (BOOL) updateWorkout:(NSString*)endTime;

+ (BOOL) insertWorkoutExercise: (NSNumber*)workoutId :(NSString*)exerciseName :(NSString*)usrUUID :(NSNumber*)numberOfReps;

+ (BOOL) insertChallenge:(NSString*)challengerUUID :(NSString*)exerciseName :(NSString*) usrUUID;

+ (BOOL) insertBadge:(NSString*)name :(NSString*)description;

+ (BOOL) insertBadgeUser:(NSNumber*)badgeId :(NSString*)userUUID;

+ (BOOL) createDatabase;
+ (BOOL) removeDatabase;
+ (BOOL) openDatabase;
+ (BOOL) closeDatabase;
@end
