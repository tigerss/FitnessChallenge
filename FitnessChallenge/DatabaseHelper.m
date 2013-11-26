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
            char *usernameChars = (char *) sqlite3_column_text(statement, 1);
            char *passwordChars = (char *) sqlite3_column_text(statement, 2);
            char *numeChars = (char *) sqlite3_column_text(statement, 3);
            char *prenumeChars = (char *) sqlite3_column_text(statement, 4);
            char *dateChars = (char *) sqlite3_column_text(statement, 5);
            
            NSString *username = [[NSString alloc] initWithUTF8String:usernameChars];
            NSString *password = [[NSString alloc] initWithUTF8String:passwordChars];
            NSString *nume = [[NSString alloc] initWithUTF8String:numeChars];
            NSString *prenume = [[NSString alloc] initWithUTF8String:prenumeChars];
            NSString *date = [[NSString alloc] initWithUTF8String:dateChars];
            
            User* user = [User alloc];
            [user set_id:[NSNumber numberWithInt:uniqueId]];
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
        sqlite3_bind_text(statement, 3, [lname UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [fname UTF8String], -1, SQLITE_TRANSIENT);
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



+ (BOOL) insertUser:(NSString*) username :(NSString*) password :(NSString*) nume :(NSString*) prenume :(NSString*) regDate {
    const char* sql_stmt = "insert into user (username, password, nume, prenume, regDate) values(?, ?, ?, ?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [username UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [password UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 3, [nume UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 4, [prenume UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 5, [regDate UTF8String], -1, SQLITE_TRANSIENT);
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

+ (BOOL) insertWorkout:(NSDate*)startTime :(NSDate*)endTime :(NSNumber*) esteTest :(NSNumber*) userId{
    const char* sql_stmt = "insert into workout (start_time, end_time, este_test, user_id) values(?, ?, ?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_int(stmt, 1, [startTime timeIntervalSince1970]);
        sqlite3_bind_int(stmt, 2, [endTime timeIntervalSince1970]);
        sqlite3_bind_int(stmt, 3, [esteTest intValue]);
        sqlite3_bind_int(stmt, 4, [userId intValue]);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (BOOL) insertWorkoutExercise: (NSNumber*) workoutId :(NSNumber*) exerciseId :(NSNumber*) userId :(NSNumber*) numberOfReps {
    const char* sql_stmt = "insert into workout_exercise (workout_id, exercise_id, user_id, reps_number) values(?, ?, ?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_int(stmt, 1, [workoutId intValue]);
        sqlite3_bind_int(stmt, 2, [exerciseId intValue]);
        sqlite3_bind_int(stmt, 3, [userId intValue]);
        sqlite3_bind_int(stmt, 4, [numberOfReps intValue]);
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
