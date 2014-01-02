//
//  PublicChallenge.m
//  FitnessChallenge
//
//  Created by Alex on 1/1/14.
//  Copyright (c) 2014 C.A.D. All rights reserved.
//

#import "PublicChallenge.h"

@implementation PublicChallenge

@synthesize challengerUsername;
@synthesize challengeeUsername;
@synthesize exerciseName;
@synthesize challengeeRepsNumber;
@synthesize challengerRepsNumber;

- (id) init {
    self = [super init];
    if (self) {
        challengeeUsername = @"";
        challengeeUsername = @"";
        exerciseName = @"";
        challengerRepsNumber = -1;
        challengeeRepsNumber = -1;
    }
    return self;
}

- (BOOL) isOpen {
    return (NO == [self hasChallengee]);
}

- (BOOL) hasChallengee {
    BOOL hasChallengee = [challengeeUsername length] > 0;
    return hasChallengee;
}

- (BOOL) isTie {
    BOOL isTie = challengerRepsNumber == challengeeRepsNumber;
    return isTie;
}

- (BOOL) isChallengerWinner {
    BOOL won = challengerRepsNumber > challengeeRepsNumber;
    return won;
}

- (BOOL) isChallengeeWinner {
    BOOL won = challengeeRepsNumber > challengerRepsNumber;
    return won;
}

- (NSDictionary*) toDictionary {
    NSMutableDictionary* result = [[NSMutableDictionary alloc]init];
    
    [result setObject:@"challenge" forKey:@"type"];
    [result setObject:challengerUsername forKey:@"challenger"];
    [result setObject:challengeeUsername forKey:@"challengee"];
    [result setObject:exerciseName forKey:@"exerciseName"];
    [result setObject:[NSNumber numberWithInt: challengerRepsNumber] forKey:@"challengerRepsNumber"];
    [result setObject:[NSNumber numberWithInt: challengeeRepsNumber] forKey:@"challengeeRepsNumber"];
    
    if (nil != self._rev && ![@""  isEqual: self._rev]) {
        [result setObject: self._rev forKey:@"_rev"];
    }
    
    return result;
}

+ (PublicChallenge*) fromDictionary:(NSDictionary*) dictionary {
    PublicChallenge* result = [[PublicChallenge alloc] init];
    
    NSString* documentId = [dictionary objectForKey:@"_id"];
    NSString* rev = [dictionary objectForKey:@"_rev"];
    NSString* challenger = [dictionary objectForKey:@"challenger"];
    NSString* challengee = [dictionary objectForKey:@"challengee"];
    NSString* exerciseName = [dictionary objectForKey:@"exerciseName"];
    NSNumber* challengerRepsNumber = [dictionary objectForKey:@"challengerRepsNumber"];
    NSNumber* challengeeRepsNumber = [dictionary objectForKey:@"challengeeRepsNumber"];
    
    [result set_id:documentId];
    [result set_rev:rev];
    [result setChallengerUsername:challenger];
    [result setChallengeeUsername:challengee];
    [result setExerciseName:exerciseName];
    [result setChallengerRepsNumber:[challengerRepsNumber intValue]];
    [result setChallengeeRepsNumber:[challengeeRepsNumber intValue]];

    
    return result;
}

@end
