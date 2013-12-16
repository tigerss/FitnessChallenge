//
//  FitnessUser.h
//  FitnessChallenge
//
//  Created by Alex on 11/28/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FitnessWorkout.h"
#import "FitnessBadge.h"

@interface FitnessUser : NSObject

@property NSString* name;
@property NSString* password;
@property NSString* uuid;
@property NSString* nume;
@property NSString* prenume;
@property NSMutableArray* workouts;
@property NSMutableArray* badges;

/**
 Cloudant fields
 */
@property NSString* _id;
@property NSString* _rev;

- (NSDictionary*) toDictionary;
+ (FitnessUser*) fromDictionary:(NSDictionary*) dictionary;
@end
