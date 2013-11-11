//
//  DatabaseHelper.m
//  FitnessChallenge
//
//  Created by Alex on 10/30/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "DatabaseHelper.h"
#import "sqlite3.h"

@implementation DatabaseHelper

sqlite3     *database;
NSString    *databasePath;

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
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS USERS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, EMAIL TEXT)";
            
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

+ (void) query {
    
}

@end
