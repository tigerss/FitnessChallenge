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


+ (void) query {
    
}

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
            char *emailChars = (char *) sqlite3_column_text(statement, 3);
            NSString *username = [[NSString alloc] initWithUTF8String:usernameChars];
            NSString *password = [[NSString alloc] initWithUTF8String:passwordChars];
            NSString *email = [[NSString alloc] initWithUTF8String:emailChars];
            User* user = [User alloc];
            [user set_id:[NSNumber numberWithInt:uniqueId]];
            [user setUsername:username];
            [user setPassword:password];
            [user setEmail:email];
            
            [retval addObject:user];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
    }
    
    return retval;
}

+ (BOOL) insertUser:(NSMutableString*) username :(NSString*) password :(NSString*) email {
    const char* sql_stmt = "insert into user (username, password, email) values(?, ?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [username UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [password UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 3, [email UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
}

+ (BOOL) updateUser:(User*) user {
    const char* sql_stmt = "update user set username = ?, password = ?, email = ? where id = ?";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_text(stmt, 1, [[user username] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [[user password] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 3, [[user email] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(stmt, 4, [[user _id] intValue]);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        return YES;
    } else {
        NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return NO;
    }
    
}

+ (BOOL) insertExercise:(NSString*) name :(NSString*) description {
    const char* sql_stmt = "insert into exercise (name, description) values(?, ?)";
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

+ (BOOL) insertWorkout:(NSNumber*) workoutNumber :(NSDate*)startTime :(NSDate*)endTime :(NSNumber*) userId {
    const char* sql_stmt = "insert into workout (workout_number, start_time, end_time, user_id) values(?, ?, ?, ?)";
    sqlite3_stmt *stmt=nil;
    int response = sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, NULL);
    if (SQLITE_OK == response) {
        sqlite3_bind_int(stmt, 1, [workoutNumber intValue]);
        sqlite3_bind_int(stmt, 2, [startTime timeIntervalSince1970]);
        sqlite3_bind_int(stmt, 3, [endTime timeIntervalSince1970]);
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
            
            sql_stmt = [TABLE_EXERCISE_CREATE_STATEMENT cStringUsingEncoding:NSASCIIStringEncoding];
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table");
            }
            
            sql_stmt = [TABLE_WORKOUT_CREATE_STATEMENT cStringUsingEncoding:NSASCIIStringEncoding];
            
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
