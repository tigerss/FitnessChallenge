//
//  FitnessChallenge_Tests.m
//  FitnessChallenge Tests
//
//  Created by Alex on 11/1/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DatabaseHelper.h"
#import "DatabaseTables.h"

@interface FitnessChallenge_Tests : XCTestCase

@end

@implementation FitnessChallenge_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*
- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}
 */

- (void)testOpenDatabase {
    BOOL result = [DatabaseHelper openDatabase];
    XCTAssertTrue(result);
    
    result = [DatabaseHelper closeDatabase];
    XCTAssertTrue(result);
}

- (void) testInsertUpdateUser {
    BOOL result = [DatabaseHelper openDatabase];
    XCTAssertTrue(result);
    
//    [DatabaseHelper insertUser:@"test" :@"test":@"test"];
//    
//    NSArray* users = [DatabaseHelper selectUsers];
//    int size = [users count];
//    NSLog(@"users: %d", size);
//    XCTAssertTrue(size > 0);
//    User* user = (User*) [users objectAtIndex:0];
//    XCTAssertTrue([[user email] isEqualToString:@"test"]);
//    
//    NSString* updateValue = @"test update";
//    [user setEmail:updateValue];
//    [DatabaseHelper updateUser:user];
//    users = [DatabaseHelper selectUsers];
//    User* updatedUser = (User*) [users objectAtIndex:0];
//    XCTAssertTrue([[updatedUser email] isEqualToString:updateValue]);
    
    result = [DatabaseHelper removeDatabase];
    XCTAssertTrue(result);
//    
//    result = [DatabaseHelper closeDatabase];
//    XCTAssertTrue(result);
}

- (void) testSelectWorkoutExercises {
    
    bool result = [DatabaseHelper openDatabase];
    XCTAssertTrue(result);
    
    NSArray* workoutExercices = [DatabaseHelper selectWorkoutExercises];
    
    for(WorkoutExercise *we in workoutExercices)
    {
    
        NSLog(@"WorkoutId: %i Exercise Name: %@ UserUUID: %@ Reps: %i",we.workoutId, we.exerciseName, we.userUUID, we.numberOfReps);
        
    }
    
    [DatabaseHelper closeDatabase];
    
}

- (void) testWorkoutsStatistics {
    
    bool result = [DatabaseHelper openDatabase];
    XCTAssertTrue(result);
    
    NSArray* workout = [DatabaseHelper selectWorkouts];
    NSArray* workoutExercices = [DatabaseHelper selectWorkoutExercises];
    int reps=0,daysNo=7;
    NSString *lastDateShown=@"";
    NSDate *currDate;
    for(Workout *w in workout)
    {
        for(WorkoutExercise *we in workoutExercices)
        {
            NSInteger workID = [w._id integerValue];
            int workExID = we.workoutId;
            if(workID==workExID)
            {
                reps=reps+we.numberOfReps;
            }
            else if(workID>workExID)
                continue;
            else
                break;
            
        }
        if(!([[w.startTime substringToIndex:10] isEqual:lastDateShown])) {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"YYYY-MM-dd"];
            NSDate *thisDate = [dateFormat dateFromString:[w.startTime substringToIndex:10]];
            currDate = [NSDate date];
            NSTimeInterval distanceBetweenDates = [currDate timeIntervalSinceDate:thisDate];
            int distanceDates = (distanceBetweenDates / 3600) / 24;
            [dateFormat setDateFormat:@"d MMM"];
            if(distanceDates>=daysNo) {
                if(w.esteTest==1)
                {

                NSLog(@"workout id: %@ date: %@ reps:%i esteTest: %i\n", w._id,[dateFormat stringFromDate:thisDate],reps, w.esteTest);
                daysNo=daysNo+7;
                }
            }
            lastDateShown = [w.startTime substringToIndex:10];
            reps=0;
        }
        else
            continue;
    }
    
    [DatabaseHelper closeDatabase];
    
}


- (void) testSelectBadges {
    
    bool result = [DatabaseHelper openDatabase];
    XCTAssertTrue(result);
    
    NSArray* badges = [DatabaseHelper selectBadges];
    
    for(Badge *b in badges)
    {
        
        NSLog(@"%@ %@ %@",b.name,b.image,b.description);
        
    }
    
    [DatabaseHelper closeDatabase];
    
}

- (void) testSelectUserBadges {
    
    bool result = [DatabaseHelper openDatabase];
    XCTAssertTrue(result);
    
    NSArray *users = [DatabaseHelper selectUsers];
    User* user = [users objectAtIndex:0];
    
    NSArray* badges = [DatabaseHelper selectBadgeUser:user.userUUID];
    int numberOfBadges = [badges count];
    
    NSLog(@"%i badges",numberOfBadges);
    
    for(BadgeUser *b in badges)
    {
        
        NSLog(@"%ld %@",(long)b.badgeId,b.userUUID);
        
    }
    
    [DatabaseHelper closeDatabase];
    
}

@end
