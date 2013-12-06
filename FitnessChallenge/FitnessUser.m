//
//  FitnessUser.m
//  FitnessChallenge
//
//  Created by Alex on 11/28/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "FitnessUser.h"

@implementation FitnessUser

@synthesize name;
@synthesize password;
@synthesize uuid;
@synthesize nume;
@synthesize prenume;
@synthesize workouts;

@synthesize _id;
@synthesize _rev;

- (id) init {
    self = [super init];
    if (self) {
        name = @"";
        workouts = [[NSMutableArray alloc]init];
        
        _id = @"";
        _rev = @"";
    }
    return self;
}

- (NSDictionary*) toDictionary {
    [self setNullStringsToEmpty];
    
    NSMutableArray* workoutsArray = [[NSMutableArray alloc]init];
    for (FitnessWorkout* workout in workouts) {
        NSDictionary* workoutDictionary = [workout toDictionary];
        [workoutsArray addObject:workoutDictionary];
    }
    
    NSMutableDictionary* result = [[NSMutableDictionary alloc]init];
    [result setObject:name forKey:@"name"];
    [result setObject:password forKey:@"password"];
    [result setObject:uuid forKey:@"uuid"];
    [result setObject:nume forKey:@"nume"];
    [result setObject:prenume forKey:@"prenume"];
    [result setObject:workoutsArray forKey:@"workouts"];
    
    if (nil != _rev && ![@""  isEqual: _rev]) {
        [result setObject:_rev forKey:@"_rev"];
    }
    
    return  result;
}

+ (FitnessUser*) fromDictionary:(NSDictionary*) dictionary {
    FitnessUser* user = [[FitnessUser alloc]init];

    NSString* name = [dictionary objectForKey:@"name"];
    NSString* passsword = [dictionary objectForKey:@"password"];
    NSString* uuid = [dictionary objectForKey:@"uuid"];
    NSString* nume = [dictionary objectForKey:@"nume"];
    NSString* prenume = [dictionary objectForKey:@"prenume"];
    NSString* documentId = [dictionary objectForKey:@"_id"];
    NSString* rev = [dictionary objectForKey:@"_rev"];
    NSMutableArray* fitnessWorkouts = [dictionary objectForKey:@"workouts"];
    for (NSDictionary* workoutDictionary in fitnessWorkouts) {
        FitnessWorkout* fitnessWorkout = [FitnessWorkout fromDictionary:workoutDictionary];
        [[user workouts] addObject:fitnessWorkout];
    }

    [user setName:name];
    [user setPassword:passsword];
    [user setUuid:uuid];
    [user setNume:nume];
    [user setPrenume:prenume];
    [user set_id:documentId];
    [user set_rev:rev];
    
    return user;
}

- (void)setNullStringsToEmpty {
    if (nil == name) {
        name = @"";
    }
    if (nil == password) {
        password = @"";
    }
    if (nil == uuid) {
        uuid = @"";
    }
    if (nil == nume) {
        nume = @"";
    }
    if (nil == prenume) {
        prenume = @"";
    }
}

@end
