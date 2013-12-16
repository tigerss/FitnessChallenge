//
//  FitnessBadge.m
//  FitnessChallenge
//
//  Created by Alex on 12/16/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "FitnessBadge.h"

@implementation FitnessBadge

@synthesize name;
@synthesize image;
@synthesize description;

- (id) init {
    self = [super init];
    if (self) {
        name = @"";
        image = @"";
        description = @"";
    }
    return self;
}

+ (FitnessBadge*) fromBadge: (Badge*) badge {
    FitnessBadge* fitnessBadge = [[FitnessBadge alloc]init];
    [fitnessBadge setName:[badge name]];
    [fitnessBadge setImage:[badge image]];
    [fitnessBadge setDescription:[badge description]];
    
    return fitnessBadge;
}

- (NSDictionary*) toDictionary {
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:name forKey:@"name"];
    [dictionary setObject:image forKey:@"image"];
    [dictionary setObject:description forKey:@"description"];
    
    return dictionary;
}

+ (FitnessBadge*) fromDictionary:(NSDictionary*) dictionary {
    FitnessBadge* badge = [[FitnessBadge alloc]init];
    
    NSString* name = [dictionary objectForKey:@"name"];
    NSString* image = [dictionary objectForKey:@"image"];
    NSString* description = [dictionary objectForKey:@"description"];
    
    [badge setName:name];
    [badge setImage:image];
    [badge setDescription:description];
    
    return badge;
}

@end
