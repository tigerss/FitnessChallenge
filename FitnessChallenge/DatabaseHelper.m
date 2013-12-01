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

+ (NSArray*) selectWorkout {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    const char *query = "select * from workout";
    sqlite3_stmt *statement;
    int response = sqlite3_prepare_v2(database, query, -1, &statement, nil);
    if (response == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *sTimeChars = (char *) sqlite3_column_text(statement, 1);
            char *eTimeChars = (char *) sqlite3_column_text(statement, 2);
            
            NSNumber *uId = [NSNumber numberWithInt:uniqueId];
            NSString *startTime = [[NSString alloc] initWithUTF8String:sTimeChars];
            NSString *endTime = [[NSString alloc] initWithUTF8String:eTimeChars];
            
            Workout* workout = [Workout alloc];
            [workout set_id:uId];
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

+ (BOOL) updateUser:(NSString*) username :(NSString*) password :(NSString*) nume :(NSString*) prenume :(NSString*) regDate :(NSString*) usr {
    const char* sql_stmt = "update user set username = ?, password = ?, nume = ?, prenume = ?, regDate = ? where username = ?";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [username UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [password UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 3, [nume UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 4, [prenume UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 5, [regDate UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 6, [usr UTF8String], -1, SQLITE_TRANSIENT);
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

+ (BOOL) insertBadge:(NSString*)name :(NSString*)description {
    const char* sql_stmt = "insert into badge (name, description) values(?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [description UTF8String], -1, SQLITE_TRANSIENT);
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
