//
//  FitnessExercise.m
//  FitnessChallenge
//
//  Created by Alex on 12/2/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "FitnessExercise.h"

@implementation FitnessExercise

@synthesize name;
@synthesize reps;

- (id) init {
    self = [super init];
    if (self) {
        name = @"exercitiul";
        reps = 0;
    }
    
    return self;
}

- (NSDictionary*) toDictionary {
    if (nil == name) {
        name = @"exercitiul";
    }
    NSMutableDictionary* exerciseDictionary = [[NSMutableDictionary alloc] init];
    [exerciseDictionary setObject:name forKey:@"name"];
    [exerciseDictionary setObject:[NSNumber numberWithInt:reps] forKey:@"reps"];

    return exerciseDictionary;
}

+ (FitnessExercise*) fromDictionary: (NSDictionary*) dictionary {
    FitnessExercise* exercise = [[FitnessExercise alloc]init];
    NSString* fitnessExerciseName = [dictionary objectForKey:@"name"];
    NSNumber* fitnessReps = [dictionary objectForKey:@"reps"];
    
    [exercise setName:fitnessExerciseName];
    [exercise setReps:[fitnessReps integerValue]];
    
    return exercise;
}
@end
