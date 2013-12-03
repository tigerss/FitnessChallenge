//
//  FitnessExercise.h
//  FitnessChallenge
//
//  Created by Alex on 12/2/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FitnessExercise : NSObject

@property NSString* name;
@property NSInteger reps;

- (NSDictionary*) toDictionary;
+ (FitnessExercise*) fromDictionary: (NSDictionary*) dictionary;
@end
