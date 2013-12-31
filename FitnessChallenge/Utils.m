//
//  Utils.m
//  FitnessChallenge
//
//  Created by Alex on 12/2/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Utils.h"

@implementation Utils

NSString *const DATE_TIME_FORMAT = @"yyyy-MM-dd 'at' HH:mm";
NSString *const DATE_FORMAT = @"yyyy-MM-dd";

+ (void) setUserAuthenticated {
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:@"1" forKey:@"userLevel"];    
    [standardDefaults synchronize];
}

+ (BOOL) isUserAuthenticated {
    return (NO == [Utils isUserGuest]);
}

+ (BOOL) isUserGuest {
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userLvl = [standardDefaults stringForKey:@"userLevel"];
    BOOL result = [userLvl isEqualToString:@"0"];
    return result;
}

+ (long long) convertDateStringToMilliseconds:(NSString*) dateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATE_TIME_FORMAT];
    @try {
        NSDate *date=[dateFormat dateFromString:dateString];
        long long mills = (long long)([date timeIntervalSince1970] * 1000.0);
        
        return mills;
    } @catch (NSException* ex) {
        NSLog(@"Error converting date string: %@", [ex debugDescription]);
        NSDate *today=[NSDate date];
        long long mills = (long long) ([today timeIntervalSince1970] * 1000.0);
        return mills;
    }
}

+ (NSString*) convertMillisecondsToDateTime: (long long) millis {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:(millis / 1000)];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATE_TIME_FORMAT];
    NSString *dateString=[dateFormat stringFromDate:date];
    
    return dateString;
}

+ (NSString*) dateToString {
    NSDate *today=[NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATE_FORMAT];
    NSString *dateString=[dateFormat stringFromDate:today];
    
    return dateString;
}

@end
