//
//  DatabaseHelper.m
//  FitnessChallenge
//
//  Created by Alex on 10/30/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "DatabaseHelper.h"
#import "sqlite3.h"
#import "DatabaseTables.h"

@implementation DatabaseHelper

sqlite3     *database;
NSString    *databasePath;

+ (NSArray*) selectUsers {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from user";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *userUUIDChars = (char *) sqlite3_column_text(statement, 1);
            char *usernameChars = (char *) sqlite3_column_text(statement, 2);
            char *passwordChars = (char *) sqlite3_column_text(statement, 3);
            char *numeChars = (char *) sqlite3_column_text(statement, 4);
            char *prenumeChars = (char *) sqlite3_column_text(statement, 5);
            char *dateChars = (char *) sqlite3_column_text(statement, 6);
            
            NSString *userUUID = [[NSString alloc] initWithUTF8String:userUUIDChars];
            NSString *username = [[NSString alloc] initWithUTF8String:usernameChars];
            NSString *password = [[NSString alloc] initWithUTF8String:passwordChars];
            NSString *nume = [[NSString alloc] initWithUTF8String:numeChars];
            NSString *prenume = [[NSString alloc] initWithUTF8String:prenumeChars];
            NSString *date = [[NSString alloc] initWithUTF8String:dateChars];
            
            User* user = [User alloc];
            [user set_id:[NSNumber numberWithInt:uniqueId]];
            [user setUserUUID:userUUID];
            [user setUsername:username];
            [user setPassword:password];
            [user setNume:nume];
            [user setPrenume:prenume];
            [user setRegDate:date];
            
            [retval addObject:user];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
}

+ (NSArray*) selectWorkouts {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from workout ORDER BY start_time DESC";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *sTimeChars = (char *) sqlite3_column_text(statement, 1);
            char *eTimeChars = (char *) sqlite3_column_text(statement, 2);
            int isTest = sqlite3_column_int(statement, 3);
            
            NSString *startTime = [[NSString alloc] initWithUTF8String:sTimeChars];
            NSString *endTime = [[NSString alloc] initWithUTF8String:eTimeChars];
            
            Workout* workout = [Workout alloc];
            [workout set_id:[NSNumber numberWithInt:uniqueId]];
            [workout setStartTime:startTime];
            [workout setEndTime:endTime];
            [workout setEsteTest:isTest];
            
            [retval addObject:workout];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
}

+ (NSArray*) selectWorkoutIsTest {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from workout where este_test = 1";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *sTimeChars = (char *) sqlite3_column_text(statement, 1);
            char *eTimeChars = (char *) sqlite3_column_text(statement, 2);
            
            //NSNumber *uId = [NSNumber numberWithInt:uniqueId];
            NSString *startTime = [[NSString alloc] initWithUTF8String:sTimeChars];
            NSString *endTime = [[NSString alloc] initWithUTF8String:eTimeChars];
            
            Workout* workout = [Workout alloc];
            [workout set_id:[NSNumber numberWithInt:uniqueId]];
            [workout setStartTime:startTime];
            [workout setEndTime:endTime];
            
            [retval addObject:workout];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
}

+ (NSArray*) selectWorkoutIsNotTest {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from workout where este_test = 0";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *sTimeChars = (char *) sqlite3_column_text(statement, 1);
            char *eTimeChars = (char *) sqlite3_column_text(statement, 2);
            
            NSString *startTime = [[NSString alloc] initWithUTF8String:sTimeChars];
            NSString *endTime = [[NSString alloc] initWithUTF8String:eTimeChars];
            
            Workout* workout = [Workout alloc];
            [workout set_id:[NSNumber numberWithInt:uniqueId]];
            [workout setStartTime:startTime];
            [workout setEndTime:endTime];
            
            [retval addObject:workout];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
}


+ (NSArray*) selectWorkoutExercises {
    
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from workout_exercise";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            @try {
                NSInteger numberOfReps = sqlite3_column_int(statement, 4);
                
                char *userUUIDChars = (char *) sqlite3_column_text(statement, 3);
                int workoutId = sqlite3_column_int(statement, 1);
                char *wrkNameChars = (char *) sqlite3_column_text(statement, 2);
                
                NSString *userUUID = [[NSString alloc] initWithUTF8String:userUUIDChars];
                NSString *wrkName = [[NSString alloc] initWithUTF8String:wrkNameChars];
                
                WorkoutExercise* workoutReps = [WorkoutExercise alloc];
                [workoutReps setNumberOfReps:numberOfReps];
                [workoutReps setUserUUID:userUUID];
                [workoutReps setWorkoutId:workoutId];
                [workoutReps setExerciseName:wrkName];
                
                [retval addObject:workoutReps];
            } @catch (NSException* ex) {
                NSLog(@"%@", [ex debugDescription]);
            }
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
    
}

+ (NSArray*) selectWorkoutExerciseReps :(NSNumber*) workoutId :(NSString*)usrUUID {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from workout_exercise WHERE workout_id = ? AND userUUID = ?";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        
        sqlite3_bind_int(statement, 1, [workoutId intValue]);
        sqlite3_bind_text(statement, 2, [usrUUID UTF8String], -1, SQLITE_TRANSIENT);
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            int numberOfReps = sqlite3_column_int(statement, 4);
            
            WorkoutExercise* workoutReps = [WorkoutExercise alloc];
            [workoutReps setNumberOfReps:numberOfReps];
            
            [retval addObject:workoutReps];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
}

+ (BOOL) selectUsersForAuth:(NSString*) username :(NSString*) password {

    const char *query = "select COUNT(*) from user WHERE username = ? AND password = ?";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK)
    {
        sqlite3_bind_text(statement, 1, [username UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [password UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(statement);
        
        int nr = sqlite3_column_int(statement, 0);
        sqlite3_finalize(statement);
        
        if (nr==1)
            return YES;
        
        else
            return NO;

    }
    
    else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (BOOL) selectUsersWithName:(NSString*) lname :(NSString*) fname {
    
    const char *query = "select COUNT(*) from user WHERE nume = ? AND prenume = ?";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK)
    {
        sqlite3_bind_text(statement, 1, [lname UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [fname UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(statement);
        
        int nr = sqlite3_column_int(statement, 0);
        sqlite3_finalize(statement);
        
        if (nr==1)
            return YES;
        
        else
            return NO;
        
    }
    
    else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (BOOL) selectUsersNr {
    
    const char *query = "select COUNT(*) from user";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK)
    {
        sqlite3_step(statement);
        
        int nr = sqlite3_column_int(statement, 0);
        sqlite3_finalize(statement);
        
        if (nr==1)
            return YES;
        
        else
            return NO;
        
    }
    
    else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (NSArray*) selectBadges {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from badge";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *imageChars = (char *) sqlite3_column_text(statement, 2);
            char *descriptionChars = (char *) sqlite3_column_text(statement, 3);
            
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *image = [[NSString alloc] initWithUTF8String:imageChars];
            NSString *description = [[NSString alloc] initWithUTF8String:descriptionChars];
            
            Badge* badges = [Badge alloc];
            [badges setName:name];
            [badges setImage:image];
            [badges setDescription:description];
            
            [retval addObject:badges];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
}

+ (NSArray*) selectBadges2 :(NSNumber*)badgeID {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from badge WHERE id = ?";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        
        sqlite3_bind_int(statement, 1, [badgeID intValue]);
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
        
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *imageChars = (char *) sqlite3_column_text(statement, 2);
            char *descriptionChars = (char *) sqlite3_column_text(statement, 3);
            
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *image = [[NSString alloc] initWithUTF8String:imageChars];
            NSString *description = [[NSString alloc] initWithUTF8String:descriptionChars];
            
            Badge* badges = [Badge alloc];
            [badges setName:name];
            [badges setImage:image];
            [badges setDescription:description];
            
            [retval addObject:badges];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
}

+ (NSArray*) selectBadgeUser:(NSString *)usrUUID {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from badge_user WHERE userUUID = ?";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        
        sqlite3_bind_text(statement, 1, [usrUUID UTF8String], -1, SQLITE_TRANSIENT);
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            int badgeIdChars = sqlite3_column_int(statement, 1);
            char *userUUIDChars = (char *) sqlite3_column_text(statement, 2);
            
            NSString *userUUID = [[NSString alloc] initWithUTF8String:userUUIDChars];
            
            BadgeUser* badgesUsers = [BadgeUser alloc];
            [badgesUsers setBadgeId:badgeIdChars];
            [badgesUsers setUserUUID:userUUID];
            
            [retval addObject:badgesUsers];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
}

+ (NSArray*) selectBadgeWithID :(NSNumber*)badgeId {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from badge_user WHERE badge_id = ?";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        
        sqlite3_bind_int(statement, 1, [badgeId intValue]);
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            int badgeIdChars = sqlite3_column_int(statement, 1);
            char *userUUIDChars = (char *) sqlite3_column_text(statement, 2);
            
            NSString *userUUID = [[NSString alloc] initWithUTF8String:userUUIDChars];
            
            BadgeUser* badgesUsers = [BadgeUser alloc];
            [badgesUsers setBadgeId:badgeIdChars];
            [badgesUsers setUserUUID:userUUID];
            
            [retval addObject:badgesUsers];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
}

+ (NSArray*) selectUserBadges :(NSString*)uuid {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from badge b INNER JOIN badge_user bu ON b.id = bu.badge_id INNER JOIN user u ON bu.userUUID = ?";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        
        sqlite3_bind_text(statement, 1, [uuid UTF8String], -1, SQLITE_TRANSIENT);
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *imageChars = (char *) sqlite3_column_text(statement, 2);
            char *descriptionChars = (char *) sqlite3_column_text(statement, 3);
            
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *image = [[NSString alloc] initWithUTF8String:imageChars];
            NSString *description = [[NSString alloc] initWithUTF8String:descriptionChars];
            
            Badge* badges = [Badge alloc];
            [badges setName:name];
            [badges setImage:image];
            [badges setDescription:description];
            
            [retval addObject:badges];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
}

+ (Badge*) selectBadgeByName:(NSString*)name {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from badge where name = ?";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            int uniqueId = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *imageChars = (char *) sqlite3_column_text(statement, 2);
            char *descriptionChars = (char *) sqlite3_column_text(statement, 3);
            
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *image = [[NSString alloc] initWithUTF8String:imageChars];
            NSString *description = [[NSString alloc] initWithUTF8String:descriptionChars];
            
            Badge* badges = [Badge alloc];
            [badges set_id:[NSNumber numberWithInt:uniqueId]];
            [badges setName:name];
            [badges setImage:image];
            [badges setDescription:description];
            
            [retval addObject:badges];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    if ([retval count] > 0) {
        return [retval objectAtIndex:0];
    } else {
        return [[Badge alloc] init];
    }
}


+ (BOOL) insertUser:(NSString*) usrUUID :(NSString*) username :(NSString*) password :(NSString*) nume :(NSString*) prenume :(NSString*) regDate {
    const char* sql_stmt = "insert into user (userUUID, username, password, nume, prenume, regDate) values(?, ?, ?, ?, ?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [usrUUID UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [username UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 3, [password UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 4, [nume UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 5, [prenume UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 6, [regDate UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (BOOL) updateUser:(NSString*) newUserName password:(NSString*) newPassword nume:(NSString*) newNume prenume:(NSString*) newPrenume regDate:(NSString*) regDate oldUserName:(NSString*) oldUserName {
    const char* sql_stmt = "update user set username = ?, password = ?, nume = ?, prenume = ?, regDate = ? where username = ?";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [newUserName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [newPassword UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 3, [newNume UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 4, [newPrenume UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 5, [regDate UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 6, [oldUserName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (BOOL) updateUserWithUsername:(NSString*) newUserName password:(NSString*) newPassword uuid:(NSString*)uuid nume:(NSString*)newNume prenume:(NSString*) newPrenume regDate:(NSString*) regDate oldUserName:(NSString*) oldUserName {
    const char* sql_stmt = "update user set username = ?, password = ?, userUUID = ?, nume = ?, prenume = ?, regDate = ? where username = ?";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [newUserName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [newPassword UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 3, [uuid UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 4, [newNume UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 5, [newPrenume UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 6, [regDate UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 7, [oldUserName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (BOOL) insertWorkout:(NSString*)startTime :(NSString*)endTime :(NSNumber*) esteTest :(NSString*) usrUUID{
    const char* sql_stmt = "insert into workout (start_time, end_time, este_test, userUUID) values(?, ?, ?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [startTime UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [endTime UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(stmt, 3, [esteTest intValue]);
        sqlite3_bind_text(stmt, 4, [usrUUID UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (BOOL) updateWorkout:(NSString*)endTime {
    const char* sql_stmt = "update workout set end_time = ?";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [endTime UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}


+ (BOOL) insertWorkoutExercise: (NSNumber*) workoutId :(NSString*) exerciseName :(NSString*) usrUUID :(NSNumber*) numberOfReps {
    const char* sql_stmt = "insert into workout_exercise (workout_id, exercise_name, userUUID, reps_number) values(?, ?, ?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_int(stmt, 1, [workoutId intValue]);
        sqlite3_bind_text(stmt, 2, [exerciseName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 3, [usrUUID UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(stmt, 4, [numberOfReps intValue]);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (BOOL) insertChallenge:(NSString*) challengerUUID :(NSString*) exerciseName :(NSString*) usrUUID{
    const char* sql_stmt = "insert into challenge (challengerUUID, exercise_name, userUUID) values(?, ?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [challengerUUID UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [exerciseName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 3, [usrUUID UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (BOOL) insertBadge:(NSString*)name :(NSString*)image :(NSString*)description {
    const char* sql_stmt = "insert into badge (name, image, description) values(?, ?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [image UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 3, [description UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (BOOL) insertBadgeUser:(NSNumber*)badgeId :(NSString*)userUUID {
    const char* sql_stmt = "insert into badge_user (badge_id, userUUID) values(?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_int(stmt, 1, [badgeId intValue]);
        sqlite3_bind_text(stmt, 2, [userUUID UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (int) getLastInsertRowId {
    int rowId = sqlite3_last_insert_rowid(database);
    return rowId;
}

+ (BOOL) openDatabase {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"fitness.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
        return [DatabaseHelper createDatabase];
    } else {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            return YES;
        }
        else {
            NSLog(@"Failed to open database");
            return NO;
        }
    }
}

+ (BOOL) closeDatabase {
    int result = sqlite3_close(database);
    
    if (SQLITE_OK == result) {
        return YES;
    }
    
    NSLog(@"Failed to close database, error code: %d", result);
    
    return NO;
}
    
+ (BOOL) createDatabase {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"fitness.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt = [TABLE_USER_CREATE_STATEMENT cStringUsingEncoding:NSASCIIStringEncoding];
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table");
            }
            
            sql_stmt = [TABLE_WORKOUT_CREATE_STATEMENT cStringUsingEncoding:NSASCIIStringEncoding];
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table");
            }
            
            sql_stmt = [TABLE_CHALLENGE_CREATE_STATEMENT cStringUsingEncoding:NSASCIIStringEncoding];
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table");
            }
            
            sql_stmt = [TABLE_BADGE_CREATE_STATEMENT cStringUsingEncoding:NSASCIIStringEncoding];
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table");
            }
            
            sql_stmt = [TABLE_BADGE_USER_CREATE_STATEMENT cStringUsingEncoding:NSASCIIStringEncoding];
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table");
            }

            sql_stmt = [TABLE_WORKOUT_EXERCISE_CREATE_STATEMENT cStringUsingEncoding:NSASCIIStringEncoding];
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table");
            }
            
            return YES;
            //sqlite3_close(database);
        }
        else {
            NSLog(@"Failed to open/create database");
        }
    }
    
    return NO;
}
    
+ (BOOL) removeDatabase {
    if (NO == [DatabaseHelper closeDatabase]) {
        return NO;
    }
    
    NSError *err;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    err = nil;
    
    NSArray* dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"fitness.db"]];
    
  //  NSString *deleteFileName = [NSString stringWithFormat:@"%@/fitness.db",[[NSBundle mainBundle] resourcePath]];
    
//    NSURL *url = [NSURL fileURLWithPath:deleteFileName];
    [fm removeItemAtPath:databasePath error:&err];
    
    if(err)
    
    {
        
        NSLog(@"File Manager: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return NO;
    }
    
    else
    
    {
        
        NSLog(@"File %@ deleted.",@"fitness.db");
        return YES;
    }
}

@end
