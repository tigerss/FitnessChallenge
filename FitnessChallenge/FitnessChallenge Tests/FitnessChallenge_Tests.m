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

- (void) testInsertUser {
    BOOL result = [DatabaseHelper openDatabase];
    XCTAssertTrue(result);
    
    [DatabaseHelper insertUser:@"test" :@"test":@"test"];
    
    NSArray* users = [DatabaseHelper selectUsers];
    int size = [users count];
    NSLog(@"users: %d", size);
    XCTAssertTrue(size > 0);
    User* user = (User*) [users objectAtIndex:0];
    XCTAssertTrue([[user email] isEqualToString:@"test"]);
    
    result = [DatabaseHelper removeDatabase];
    XCTAssertTrue(result);
//    
//    result = [DatabaseHelper closeDatabase];
//    XCTAssertTrue(result);
}
@end
