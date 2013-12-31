//
//  Utils.h
//  FitnessChallenge
//
//  Created by Alex on 12/2/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

extern NSString *const DATE_TIME_FORMAT;
extern NSString *const DATE_FORMAT;

+ (void) setUserAuthenticated;
+ (BOOL) isUserAuthenticated;
+ (BOOL) isUserGuest;

+ (long long) convertDateStringToMilliseconds:(NSString*) dateString;
+ (NSString*) convertMillisecondsToDateTime: (long long) millis;
+ (NSString*) dateToString;

@end
