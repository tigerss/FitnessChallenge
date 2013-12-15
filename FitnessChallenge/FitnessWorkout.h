//
//  FitnessWorkout.h
//  FitnessChallenge
//
//  Created by Alex on 12/2/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FitnessWorkout : NSObject

@property NSInteger workoutId;

@property long long startTime;
@property long long endTime;

@property NSMutableArray* exercises;

- (NSDictionary*) toDictionary;
+ (FitnessWorkout*) fromDictionary: (NSDictionary*) dictionary;
@end
