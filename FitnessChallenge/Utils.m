//
//  Utils.m
//  FitnessChallenge
//
//  Created by Alex on 12/2/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Utils.h"

@implementation Utils

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
    [dateFormat setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
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

+ (NSString*) dateToString {
    NSDate *today=[NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString=[dateFormat stringFromDate:today];
    
    return dateString;
}
@end
