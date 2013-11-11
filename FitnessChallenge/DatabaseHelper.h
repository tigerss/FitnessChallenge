//
//  DatabaseHelper.h
//  FitnessChallenge
//
//  Created by Alex on 10/30/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseHelper : NSObject

+ (BOOL) createDatabase;
+ (BOOL) removeDatabase;
+ (BOOL) openDatabase;
+ (BOOL) closeDatabase;
@end
