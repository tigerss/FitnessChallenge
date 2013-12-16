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
+ (NSArray*) selectWorkoutIsTest;
+ (NSArray*) selectWorkoutIsNotTest;
+ (NSArray*) selectWorkouts;
+ (NSArray*) selectWorkoutExerciseReps :(NSNumber*) workoutId :(NSString*)usrUUID;

+ (NSArray*) selectBadges;
+ (NSArray*) selectBadges2 :(NSNumber*)badgeID;
+ (NSArray*) selectBadgeUser :(NSString*)usrUUID;
+ (NSArray*) selectBadgeWithID :(NSNumber*)badgeId;
+ (NSArray*) selectUserBadges :(NSString*)uuid;
+ (Badge*) selectBadgeByName:(NSString*)name;

+ (BOOL) selectUsersForAuth:(NSString*) username :(NSString*) password;

+ (BOOL) selectUsersWithName:(NSString*) lname :(NSString*) fname;

+ (BOOL) selectUsersNr;

+ (BOOL) insertUser:(NSString*) usrUUID :(NSString*) username :(NSString*) password :(NSString*) nume :(NSString*) prenume :(NSString*) regDate;

+ (BOOL) updateUser:(NSString*) newUserName password:(NSString*) newPassword nume:(NSString*) newNume prenume:(NSString*) newPrenume regDate:(NSString*) regDate oldUserName:(NSString*) oldUserName;

+ (BOOL) updateUserWithUsername:(NSString*) newUserName password:(NSString*) newPassword uuid:(NSString*)uuid nume:(NSString*)newNume prenume:(NSString*) newPrenume regDate:(NSString*) regDate oldUserName:(NSString*) oldUserName;

+ (BOOL) insertWorkout:(NSString*)startTime :(NSString*)endTime :(NSNumber*)esteTest :(NSString*)usrUUID;

+ (BOOL) updateWorkout:(NSString*)endTime;

+ (NSArray*) selectWorkoutExercises;

+ (BOOL) insertWorkoutExercise: (NSNumber*)workoutId :(NSString*)exerciseName :(NSString*)usrUUID :(NSNumber*)numberOfReps;

+ (BOOL) insertChallenge:(NSString*)challengerUUID :(NSString*)exerciseName :(NSString*) usrUUID;

+ (BOOL) insertBadge:(NSString*)name :(NSString*)image :(NSString*)description;

+ (BOOL) insertBadgeUser:(NSNumber*)badgeId :(NSString*)userUUID;

+ (int) getLastInsertRowId;

+ (BOOL) createDatabase;
+ (BOOL) removeDatabase;
+ (BOOL) openDatabase;
+ (BOOL) closeDatabase;
@end
