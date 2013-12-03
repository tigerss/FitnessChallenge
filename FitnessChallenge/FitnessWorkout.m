//
//  FitnessWorkout.m
//  FitnessChallenge
//
//  Created by Alex on 12/2/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "FitnessWorkout.h"
#import "FitnessExercise.h"

@implementation FitnessWorkout

@synthesize workoutId;
@synthesize starTime;
@synthesize endTime;
@synthesize exercises;

- (id) init {
    self = [super init];
    if (self) {
        starTime = 0;
        endTime = 0;
        exercises = [[NSMutableArray alloc]init];
    }
    
    return self;
}

- (NSDictionary*) toDictionary {
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:[NSNumber numberWithInt:workoutId] forKey:@"workout_id"];
    [dictionary setObject:[NSNumber numberWithLongLong:starTime] forKey:@"startTime"];
    [dictionary setObject:[NSNumber numberWithLongLong:endTime] forKey:@"endTime"];
    
    NSMutableArray* fitnessExercises = [[NSMutableArray alloc]init];
    for (FitnessExercise* exercise in exercises) {
        NSDictionary* exerciseDictionary = [exercise toDictionary];
        [fitnessExercises addObject:exerciseDictionary];
    }
    
    [dictionary setObject:fitnessExercises forKey:@"exercises"];
    
    return dictionary;
}

+ (FitnessWorkout*) fromDictionary: (NSDictionary*) dictionary {
    FitnessWorkout* result = [[FitnessWorkout alloc]init];
    
    NSNumber* fitnessWorkoutId = [dictionary objectForKey:@"workout_id"];
    NSNumber* fitnessStartTime = [dictionary objectForKey:@"startTime"];
    NSNumber* fitnessEndTime = [dictionary objectForKey:@"endTime"];
    NSMutableArray* fitnessExercises = [dictionary objectForKey:@"exercises"];
    
    for (NSDictionary* exerciseDictionary in fitnessExercises) {
        FitnessExercise* fitnessExercise = [FitnessExercise fromDictionary:exerciseDictionary];
        [[result exercises] addObject:fitnessExercise];
    }
    
    [result setWorkoutId:[fitnessWorkoutId intValue]];
    [result setStarTime:[fitnessStartTime longLongValue]];
    [result setEndTime:[fitnessEndTime longLongValue]];
    
    return result;
}
@end
