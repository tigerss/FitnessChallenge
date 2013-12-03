//
//  Utils.m
//  FitnessChallenge
//
//  Created by Alex on 12/2/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Utils.h"

@implementation Utils

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
@end
