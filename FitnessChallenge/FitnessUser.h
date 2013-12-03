//
//  FitnessUser.h
//  FitnessChallenge
//
//  Created by Alex on 11/28/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FitnessWorkout.h"

@interface FitnessUser : NSObject

@property NSString* name;
@property NSMutableArray* workouts;

/**
 Cloudant fields
 */
@property NSString* _id;
@property NSString* _rev;

- (NSDictionary*) toDictionary;
+ (FitnessUser*) fromDictionary:(NSDictionary*) dictionary;
@end
